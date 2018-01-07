defmodule Parser do
  @addition ?+
  @subtraction ?-
  @multiplication ?*
  @division ?/
  @space ?\s

  def number([?- | tail]), do: _number(tail, 0) * -1
  def number([?+ | tail]), do: _number(tail, 0)
  def number([@space | tail]), do: _number(tail, 0)
  def number(chars), do: _number(chars, 0)
  defp _number([], total), do: total
  defp _number([digit | tail], total) when digit in '0123456789' do
    _number(tail, total * 10 + digit - ?0)
  end
  defp _number([head | _tail], _total) do
    raise "Not a number: '#{inspect head}'"
  end

  def calculate(input) do
    _calculate(input, '')
  end
  defp _calculate([head|tail], left_term) when head == @addition do
    number(left_term) + number(tail)
  end
  defp _calculate([head|tail], left_term) when head == @subtraction do
    number(left_term) - number(tail)
  end
  defp _calculate([head|tail], left_term) when head == @multiplication do
    number(left_term) * number(tail)
  end
  defp _calculate([head|tail], left_term) when head == @division do
    number(left_term) / number(tail)
  end
  defp _calculate([head|tail], left_term) when head == @space do
    _calculate(tail, left_term)
  end
  defp _calculate([head|tail], left_term) do
    _calculate(tail, left_term ++ [head])
  end
  defp _calculate([], left_term) do
    left_term
  end
end

check_input = fn(input) ->
  IO.puts "'#{input}' = #{Parser.calculate(input)}"
end

check_input.('123 + 27')
check_input.('125 / 5')
check_input.('300 - 66')
check_input.('40 * 7')
