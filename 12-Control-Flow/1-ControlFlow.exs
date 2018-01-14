defmodule FizzBuzz do
  def print_for_number(n) do
    case n do
      n when rem(n, 15) == 0  -> IO.puts "#{n}: FizzBuzz"
      n when rem(n, 5) == 0   -> IO.puts "#{n}: Buzz"
      n when rem(n, 3) == 0   -> IO.puts "#{n}: Fizz"
      _                       -> IO.puts "#{n}: #{n}"
    end
  end
end


Enum.each(1..33, &FizzBuzz.print_for_number/1)
