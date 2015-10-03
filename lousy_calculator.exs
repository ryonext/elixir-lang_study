defmodule LousyCalculator do
  @typedoc """
  just a number followed by a string.
  """
  @type number_with_offense :: { number, String.t }

  @spec add(number, number) :: number_with_offense
  def add(x, y), do: { x + y, "You need a calculator to do that?!" }

  @spec multiply(number, number) :: number_with_offense
  def multiply(x, y), do: { x * y, "Jeez, come on!" }
end
