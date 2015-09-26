defmodule Foo do
  defmodule Bar do
  end
end

defmodule Foo.Bar do
end

defmodule Foo do
  alias Foo.Bar, as: Bar
end

defmodule Elixir.Foo do
  defmodule Elixir.Foo.Bar do
  end
  alias Elixir.Foo.Bar, as: Bar
end
