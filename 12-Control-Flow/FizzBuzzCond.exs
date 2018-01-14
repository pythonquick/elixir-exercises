defmodule FizzBuzz do
  def upto(n) do
    _upto(1, n, [])
  end


  defp _upto(_current, 0, results), do: Enum.reverse(results)

  defp _upto(current, remaining, results) do
    next = cond do
      rem(current, 15) == 0 -> "FizzBuzz"
      rem(current, 3) == 0 -> "Fizz"
      rem(current, 5) == 0 -> "Buzz"
      true -> current
    end
    _upto(current + 1, remaining - 1, [next | results])
  end
end


fizzbuzz_indexed = FizzBuzz.upto(33) |> Enum.with_index(1)
Enum.each(fizzbuzz_indexed, fn({output, idx}) ->
  IO.puts "#{idx}: #{output}"
end)
