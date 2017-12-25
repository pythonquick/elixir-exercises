defmodule Times do
  def double(n), do: n * 2
  def quadruple(n), do: double(n) * double(n)
end

IO.puts "Quadruple of 16 is #{Times.quadruple 16}"
