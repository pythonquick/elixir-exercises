defmodule FizzBuzz do
  def for_number(n) do
    _for_number(n, rem(n, 5), rem(n, 3))
  end

  def _for_number(_, _divisible_by_5 = 0, _divisible_by_3 = 0), do: "FizzBuzz"
  def _for_number(_, _divisible_by_5 = 0, _),                   do: "Buzz"
  def _for_number(_, _, _divisible_by_3 = 0),                   do: "Fizz"
  def _for_number(n, _, _),                                     do: n
end

Enum.each(1..33, fn(idx) ->
  IO.puts "#{idx}: #{FizzBuzz.for_number(idx)}"
end)
