defmodule Parse do
  def number([?- | tail]), do: _number(tail, 0) * -1
  def number([?+ | tail]), do: _number(tail, 0)
  def number(chars), do: _number(chars, 0)

  defp _number([], total), do: total
  defp _number([digit | tail], total) when digit in '0123456789' do
    _number(tail, total * 10 + digit - ?0)
  end
  defp _number([head | _tail], _total) do
    raise "Not a number: #{inspect head}"
  end
end

defmodule Main do
  def main do
    IO.inspect Parse.number('123')
    IO.inspect Parse.number('-123')
    IO.inspect Parse.number('+123')
  end
end


Main.main
