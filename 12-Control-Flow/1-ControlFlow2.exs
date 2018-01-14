defmodule FizzBuzz do
  def for_number(n) do
    case {rem(n, 5), rem(n, 3)} do
      {0, 0}  -> "FizzBuzz"
      {0, _}  -> "Buzz"
      {_, 0}  -> "Fizz"
      _       -> n
    end
  end
end


Enum.each(1..33, &(IO.puts "#{&1}: #{FizzBuzz.for_number(&1)}"))

