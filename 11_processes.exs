receive do
  {:hello, msg} -> msg
after
  1_000 -> IO.puts "nothing after 1s"
end

parent = self()
spawn fn -> send(parent, {:hello, self()}) end
receive do
  {:hello, pid} -> IO.puts "Got hello from #{inspect pid}"
end
