defmodule FizzBuzz do
  def for_number(n) when rem(n, 15) == 0, do: "FizzBuzz"
  def for_number(n) when rem(n, 5) == 0, do: "Buzz"
  def for_number(n) when rem(n, 3) == 0, do: "Fizz"
  def for_number(n), do: n
end

Enum.each(1..33, fn(idx) ->
  IO.puts "#{idx}: #{FizzBuzz.for_number(idx)}"
end)
