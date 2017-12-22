defmodule Numbers do
  def sum(0) do
    0
  end

  def sum(n) do
    n + sum(n-1)
  end
end

IO.puts "Sum(0) = #{Numbers.sum(0)}"
IO.puts "Sum(1) = #{Numbers.sum(1)}"
IO.puts "Sum(2) = #{Numbers.sum(2)}"
IO.puts "Sum(3) = #{Numbers.sum(3)}"
IO.puts "Sum(4) = #{Numbers.sum(4)}"
IO.puts "Sum(9) = #{Numbers.sum(9)}"
