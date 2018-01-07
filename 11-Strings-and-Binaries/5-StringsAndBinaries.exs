print_string = fn(text, max_len) ->
  padding = div(max_len - String.length(text), 2)
  width = String.length(text) + padding
  IO.puts String.pad_leading(text, width)
end

center = fn(texts) ->
  max = Enum.max_by(texts, &(String.length(&1)))
  max_len = String.length(max)
  Enum.each(texts, &(print_string.(&1, max_len)))
end


center.(["cat", "zebra", "elephant"])
