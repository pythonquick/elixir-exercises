defmodule MyList do
  def mapsum([], _), do: 0
  def mapsum([head|tail], func), do: func.(head) + mapsum(tail, func)
end

list = [1,2,3]
IO.puts "mapsum of #{inspect list} is #{MyList.mapsum list, &(&1 * &1)}"


