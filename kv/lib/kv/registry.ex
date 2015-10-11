defmodule KV.Registry do
  use GenServer

  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(table, event_manager, buckets, opts \\ []) do
    # 1. We now expect the table as argument and pass it to the sever
    GenServer.start_link(__MODULE__, {table, event_manager, buckets}, opts)
  end

  @doc """
  Looks up the bucket pid for `name` stored in `table`.

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def lookup(table, name) do
    # 2. lookup now expectes a table and looks directly into ETS.
    #    No request is sent to the server.
    case :ets.lookup(table, name) do
      [{^name, bucket}] -> {:ok, bucket}
      [] -> :error
    end
  end

  @doc """
  Ensures there is a bucket associated to the given `name` in `server`.
  """
  def create(server, name) do
    GenServer.call(server, {:create, name})
  end

  def handle_call({:create, name}, _from, state) do
    case lookup(state.names, name) do
      {:ok, pid} ->
        {:reply, pid, state} #Reply with pid
      :error ->
        {:ok, pid} = KV.Bucket.Supervisor.start_bucket(state.buckets)
        ref = Process.monitor(pid)
        refs = HashDict.put(state.refs, ref, name)
        :ets.insert(state.names, {name, pid})
        GenEvent.sync_notify(state.events, {:create, name, pid})
        {:reply, pid, %{state | refs: refs}} # Reply with pid
    end
  end

  def init({table, events, buckets}) do
    # 3. We have replaced the names HashDict by the ETS table
    refs = :ets.foldl(fn {name, pid}, acc ->
      HashDict.put(acc, Process.monitor(pid), name)
    end, HashDict.new, table)
    {:ok, %{names: table, refs: refs, events: events, buckets: buckets}}
  end

  # 4. The previous handle_call callback for lookup was removed

  def handle_cast({:create, name}, state) do
    # 5. Read and write to the ETS table instead of the HashDict
    case lookup(state.names, name) do
      {:ok, _pid} ->
        {:noreply, state}
      :error ->
        {:ok, pid} = KV.Bucket.Supervisor.start_bucket(state.buckets)
        ref = Process.monitor(pid)
        refs = HashDict.put(state.refs, ref, name)
        :ets.insert(state.names, {name, pid})
        GenEvent.sync_notify(state.events, {:create, name, pid})
        {:noreply, %{state | refs: refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, pid, _reason}, state) do
    # 5. Delte from the ETS table instead of the HashDict
    {name, refs} = HashDict.pop(state.refs, ref)
    :ets.delete(state.names, name)
    GenEvent.sync_notify(state.events, {:exit, name, pid})
    {:noreply, %{state | refs: refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
