defmodule Parser do
  use Behaviour

  defcallback parse(String.t) :: any
  defcallback extensions() :: [String.t]
end

defmodule JSONParser do
  @behaviour Parser
  def parse(str), do: #... parse JSON
  def extensions, do: ["json"]
end

defmodule YAMLParser do
  @behaviour Parser

  def parse(str), do: #... parse YAML
  def extensions, do: ["yml"]
end
