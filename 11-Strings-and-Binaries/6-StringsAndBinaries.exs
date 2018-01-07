defmodule Text do
  def capitalize_sentences(text) when is_binary(text) do
    _capitalize_sentences("", String.capitalize(text))
  end

  defp _capitalize_sentences(capitalized_so_far, <<?., ?\s, tail :: binary>>) do
    _capitalize_sentences("#{capitalized_so_far}#{". "}", String.capitalize(tail))
  end
  defp _capitalize_sentences(capitalized_so_far, <<head :: utf8, tail :: binary>>) do
    _capitalize_sentences("#{capitalized_so_far}#{<<head>>}", tail)
  end
  defp _capitalize_sentences(capitalized_so_far, <<>>) do
    capitalized_so_far
  end
end


IO.puts Text.capitalize_sentences("oh. a DOG. woof. ")
