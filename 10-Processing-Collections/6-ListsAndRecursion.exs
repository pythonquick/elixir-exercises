defmodule Listo do
  def flatten([]), do: []
  def flatten([head|tail]) when is_list head do
    flatten(head) ++ flatten(tail)
  end
  def flatten([head|tail]) do
    [head|flatten(tail)]
  end
end


defmodule Main do
  defp list_to_string list do
    "#{inspect list, charlists: :as_lists}"
  end
  def main do
    list = [1, [2, 3, [4]], 5, [[[6]]]]

    IO.puts "List #{list_to_string list} ::"
    IO.puts "flattened: #{list_to_string Listo.flatten list}"
  end
end

Main.main
