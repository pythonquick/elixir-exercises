fizzbuzz_check = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, n -> n
end


fizzbuzz = fn(n) -> fizzbuzz_check.(rem(n, 3), rem(n, 5), n) end
print_fizzbuzz = fn(n) ->
  IO.puts "#{n}: #{fizzbuzz.(n)}"
end

Enum.each(1..100, &(print_fizzbuzz.(&1)) )
