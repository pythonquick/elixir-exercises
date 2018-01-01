# Operations on Enumerables without using the Enum module
defmodule Listo do
  def all?([], _), do: true
  def all?([head|tail], func) do
    func.(head) && all?(tail, func)
  end

  def reverse([]), do: []
  def reverse([head|tail]) do
    reverse(tail) ++ [head]
  end

  def each([], _), do: :ok
  def each([head|tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _), do: []
  def filter([head|tail], func) do
    func.(head) && [head|filter(tail, func)] || filter(tail, func)
  end

  def split(_list, num, pos \\ 1, left \\ [], right \\ [])
  def split([], _num, _pos, left, right) do
    {left |> reverse, right |> reverse}
  end
  def split([head|tail], num, pos, left, right) when num >= 0 and num >= pos do
    split(tail, num, pos+1, [head|left], right)
  end
  def split([head|tail], num, pos, left, right) when num >= 0 and num < pos do
    split(tail, num, pos+1, left, [head|right])
  end
  # Handle negative count: counting from end of list:
  def split(list, num, pos, left, right) when num < 0 do
    {left, right} = split(list |> reverse, -num, pos, left, right)
    {right |> reverse, left |> reverse}
  end

  def take(_list, num, pos \\ 1)
  def take([], _num, _pos), do: []
  def take([head|tail], num, pos) when num >= 0 and num >= pos do
    [head | take(tail, num, pos+1)]
  end
  def take([head|tail], num, pos) when num >= 0 and num < pos do
    []
  end
  # Handle negative count: counting from end of list:
  def take(list, num, pos) when num < 0 do
    take(list |> reverse, -num)
    |> reverse
  end
end


defmodule Main do
  defp list_to_string list do
    "#{inspect list, charlists: :as_lists}"
  end
  def main do
    list = [1,2,3,4,5,6,7,8,9]

    IO.puts "List #{list_to_string list} ::"

    # all? function:
    IO.puts "all elements greater than 0? #{Listo.all? list, &(&1 > 0)}"
    IO.puts "all elements greater than 1? #{Listo.all? list, &(&1 > 1)}"
    IO.puts "all elements less than 10? #{Listo.all? list, &(&1 < 10)}"
    IO.puts "all elements equal? #{Listo.all? list, &(rem(&1, 2) == 0)}"
    IO.puts '.'

    # each function:
    IO.puts "each list item doubled:"
    Listo.each list, &(IO.puts &1 * 2)
    IO.puts "each list item even or odd:"
    Listo.each list, &(IO.puts "#{&1}: #{rem(&1, 2) == 0 && "even" || "odd"}")
    IO.puts '.'

    # filter function:
    IO.puts "filter list, only evens: #{list_to_string Listo.filter(list, &(rem(&1, 2) == 0))}"
    IO.puts "filter list, only greater than 5: #{list_to_string Listo.filter(list, &(&1 > 5))}"
    IO.puts '.'

    # split function:
    IO.puts "split list, 4-5:"
    {first, second} = Listo.split(list, 4)
    IO.puts "#{list_to_string first} / #{list_to_string second}"
    IO.puts "split list, 2-7:"
    {first, second} = Listo.split(list, 2)
    IO.puts "#{list_to_string first} / #{list_to_string second}"
    IO.puts "split list, 20-0:"
    {first, second} = Listo.split(list, 20)
    IO.puts "#{list_to_string first} / #{list_to_string second}"
    IO.puts "split list, -3:"
    {first, second} = Listo.split(list, -3)
    IO.puts "#{list_to_string first} / #{list_to_string second}"
    IO.puts "."

    # take function:
    IO.puts "take list, 0: #{list_to_string Listo.take list, 0}"
    IO.puts "take list, 1: #{list_to_string Listo.take list, 1}"
    IO.puts "take list, 2: #{list_to_string Listo.take list, 2}"
    IO.puts "take list, 3: #{list_to_string Listo.take list, 3}"
    IO.puts "take list, 4: #{list_to_string Listo.take list, 4}"
    IO.puts "take list, -4: #{list_to_string Listo.take list, -4}"
    IO.puts "take list, -3: #{list_to_string Listo.take list, -3}"
    IO.puts "take list, -2: #{list_to_string Listo.take list, -2}"
    IO.puts "take list, -1: #{list_to_string Listo.take list, -1}"

    IO.puts "."
    IO.puts "reverse: #{list_to_string Listo.reverse list}"
  end
end

Main.main
