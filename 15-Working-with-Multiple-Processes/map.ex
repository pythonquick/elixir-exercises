defmodule NonParallel do
  def schmap(collection, func) do
    collection
    |> Enum.map(&(func.(&1)))
  end

  def run(n) do
    {microseconds, _result} = :timer.tc(NonParallel, :schmap, [1..n, &:math.sqrt/1])
    IO.puts "Running through collection of #{n} items with took #{microseconds / 1_000_000} seconds"
  end
end

