defmodule PoliteCalculator do
  @spec add(number, number) :: number
  def add(x, y), do: make_polite(LousyCalculator.add(x, y))

  @spec make_polite(LousyCalculator.number_with_offense) :: number
  defp make_polite({num, _offense}), do: num
end
