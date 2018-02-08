defmodule Parallel do
  def pmap(collection, func) do
    me = self()
    collection
    |> Enum.map(&(spawn_link (fn() -> send me, {self(), func.(&1)} end)))
    |> Enum.map(fn (pid) ->
      receive do
        {^pid, result} -> result
      end
    end)
  end

  def run(n) do
    {microseconds, _result} = :timer.tc(Parallel, :pmap, [1..n, &:math.sqrt/1])
    IO.puts "Running through collection of #{n} items with parallel processes took #{microseconds / 1_000_000} seconds"
  end
end
