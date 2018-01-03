defmodule MyList do
  def span(from, to) when from <= to do
    [from | span(from + 1, to)]
  end
  def span(_, _) do
    []
  end


  def prime_numbers(n) do
    for x <- span(2, n), not Enum.any?(span(2, x-1), &(rem(x, &1) == 0)), do: x
    #for x <- 2..n, not Enum.any?(2..x-1, &(rem(x, &1) == 0)), do: x
  end


end


IO.puts "Prime numbers from 2 to 100:"
IO.inspect MyList.prime_numbers(100)

