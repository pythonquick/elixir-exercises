defmodule Parallel do
  def pmap(collection, func) do
    me = self()
    collection
    |> Enum.map(&(spawn_link (fn() -> send me, {self(), func.(&1)} end)))
    |> Enum.map(fn (_pid) ->
      receive do
        {_pid, result} -> result
      end
    end)
  end

  def run(n) do
    # Without using the pin operator in the pmap function, the items in the
    # resulting list do not map to the order of the original collection.
    # When calling the run function with a collection size that's greater than
    # a few (e.g. 100), this effect can be noticed. Collection size might depend
    # on your environment and hardware.
    result = Parallel.pmap(1..n, &:math.sqrt/1)
    sorted = Enum.sort(result)
    IO.puts "Are results in order? #{result === sorted}"
  end
end

