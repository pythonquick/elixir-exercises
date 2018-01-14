defmodule FizzBuzz do
  def for_number(number) do
    cond do
      rem(number, 15) == 0 -> "FizzBuzz"
      rem(number, 3) == 0 -> "Fizz"
      rem(number, 5) == 0 -> "Buzz"
      true -> number
    end
  end
end


Enum.each(1..33, fn(idx) ->
  IO.puts "#{idx}: #{FizzBuzz.for_number(idx)}"
end)
