prefix = fn(pref) ->
  fn(name) -> "#{pref} #{name}" end
end


miss = prefix.("Miss")
mr = prefix.("Mr")


IO.puts(mr.("Harrison Ford"))
IO.puts(miss.("Sandra Bullocks"))
