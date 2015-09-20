case {1, 2, 3}do
  {4, 5, 6} ->
    IO.puts "This clause won't match"
  {1, x, 3} ->
    IO.puts "This clause will match and bind x to 2 in this clause"
  _ ->
    IO.puts "This clause would match any value"
end

cond do
  2 + 2 == 5 ->
    IO.puts "This will not be true"
  2 * 2 == 3 ->
    IO.puts "Nor this"
  1 + 1 == 2 ->
    IO.puts "But this will"
end

if true do
  IO.puts "This works!"
end

unless true do
  IO.puts "This will never be seen"
end

IO.puts if true, do: 1+2

if true do
  a = 1 + 2
  a + 10
end

IO.puts if true, do: (
  a = 1 + 2
  a + 10
)

IO.puts if false, do: :this, else: :that
