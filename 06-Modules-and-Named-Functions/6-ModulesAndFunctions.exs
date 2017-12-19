defmodule Chop do
  def check_guess(actual, next, min..max) when actual == next do
    IO.puts next # found it!
  end

  def check_guess actual, next, min..max do
    cond do
      next < actual -> next_guess actual, div(next+1 + max, 2), (next+1)..max
      next > actual -> next_guess actual, div(min + next-1, 2), min..(next-1)
    end
  end

  def next_guess actual, guess, min..max do
    IO.puts "is it #{guess}"
    check_guess actual, guess, min..max 
  end

  def guess(actual, min..max) do
    next_guess actual, div(min + max, 2), min..max
  end
end


Chop.guess(273, 1..1000)
