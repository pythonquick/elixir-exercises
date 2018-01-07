defmodule Strings do
  @printable_ascii_chars ?\s..?~ # space character through tilde character
  def printableAscii?([]), do: true
  def printableAscii?([head|tail]) do
    head in @printable_ascii_chars && printableAscii?(tail)
  end
end

check_printable_ascii = fn(text) ->
  IO.puts "Is '#{text}' all printable ASCII? #{Strings.printableAscii?(text)}"
end

check_printable_ascii.('hello')
check_printable_ascii.('HELLO')
check_printable_ascii.('Señor')
check_printable_ascii.('Senior')
check_printable_ascii.('Günther')
check_printable_ascii.('Guenther')
