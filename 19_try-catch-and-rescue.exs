defmodule MyError do
  defexception message: "default message"
end

try do
  raise "oops"
rescue
  e in RuntimeError -> e
end

case File.read "hello" do
  {:ok, body} -> IO.puts "Success: #{body}"
  {:error, reason} -> IO.puts "Error: #{reason}"
end

try do
  Enum.each -50..50, fn(x) ->
    if rem(x, 13) ==0, do: throw(x)
  end
  IO.puts "Got nothing"
catch
  x -> IO.puts "Got #{x}"
end

try do
  exit "I am exiting"
catch
  :exit, _ -> IO.puts "not really"
end

#{:ok, file} = File.open "sample", [:utf8, :write]
#try do
#  IO.write file, "寿司"
#  raise "oops, something went wrong"
#after
#  File.close(file)
#end

#try do
#  raise "fail"
#  what_happened = :did_not_raise
#rescue
#  _ -> what_happened = :rescued
#end

what_happened =
  try do
    raise "fail"
    :did_not_raise
  rescue
    _ -> :rescued
  end

