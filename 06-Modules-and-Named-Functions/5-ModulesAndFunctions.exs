defmodule Numbers do
  def gcd(x, y) when y == 0, do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end


check_gcd = fn(x, y) -> IO.puts "GCD of #{x} and #{y} is #{Numbers.gcd(x, y)}" end


check_gcd.(12, 6)
check_gcd.(24, 14)
check_gcd.(60, 96)
check_gcd.(100, 120)
check_gcd.(120, 100)
check_gcd.(555, 1500)
