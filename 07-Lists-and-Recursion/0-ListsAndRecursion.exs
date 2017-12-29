defmodule Listo do
  def sum([]), do: 0
  def sum([head|tail]), do: head + sum(tail)
end

list = [1,2,3,4,5,6,7]

IO.puts "Sum of #{inspect list} is #{Listo.sum list}"
