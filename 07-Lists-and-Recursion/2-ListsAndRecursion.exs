defmodule Listo do
  def max(_, maxSoFar \\ nil)
  def max([], maxSoFar), do: maxSoFar
  def max([head|tail], maxSoFar) when maxSoFar > head, do: Listo.max(tail, maxSoFar)
  def max([head|tail], _), do: Listo.max(tail, head)
end

list = [2, 55, 3, 66, 7, 8, 59]
IO.puts "Max of #{inspect list} is #{Listo.max list, 3}"
