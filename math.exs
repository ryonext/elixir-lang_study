defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end

  def zero?(0) do
    true
  end

  def zero?(x) when is_number(x) do
    false
  end

  def some_function do
    import List, only: [duplicate: 2]
    duplicate(:ok, 10)
  end
end

IO.puts Math.sum(1, 2)
#IO.puts Math.do_sum(1, 2)

Math.zero?(0)
Math.zero?(1)
#Math.zero?([1, 2, 3])
