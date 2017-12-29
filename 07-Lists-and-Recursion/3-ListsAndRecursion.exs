defmodule MyList do
  @alphabet_length 26
  @ascii_code_for_a 96

  def caesar('', _), do: ''
  def caesar([head|tail], char_advance) do
    # Working with the range of ASCII characters 'a' (96) through 'z',
    # Advance each character in the list (first parameter) by given amount
    # (characters beyond 'z' wrap around) and return as new list:
    first_char = rem(head - @ascii_code_for_a + char_advance, @alphabet_length) + @ascii_code_for_a
    [first_char | caesar(tail, char_advance)]
  end
end

IO.puts "Caesar, what is the meaning of 13 past 'ryvkve'?'"
IO.puts "> The meaning is clear. It is #{MyList.caesar 'ryvkve', 13}"
