quote do: sum(1, 2, 3)
IO.puts Macro.to_string(quote do: sum(1, 2 + 3, 4))

number = 13
IO.puts Macro.to_string(quote do: 11 + number)

IO.puts Macro.to_string(quote do: 11 + unquote(number))
