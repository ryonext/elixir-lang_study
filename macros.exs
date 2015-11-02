defmodule Unless do
  def fun_unless(clause, expression) do
    if(!clause, do: expression)
  end

  defmacro macro_unless(clause, expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end

  defmacro unless(clause, options) do
    quote do
      if(!unquote(clause), do: unquote(options))
    end
  end
end
