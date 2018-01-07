defmodule Wordy do
  def anagram?([], []), do: true
  def anagram?([], _), do: false
  def anagram?(_, []), do: false
  def anagram?([head1 | tail1], [head2 | tail2]) when head1 == head2 do
    anagram?(tail1, tail2)
  end
  def anagram?([head1 | tail1], word2) do
    next_word2 = List.delete(word2, head1)
    head1 in word2 && anagram?(tail1, next_word2)
  end
end


check_anagram = fn(word1, word2) -> 
  IO.puts "Is '#{word1}' and '#{word2}' anagrams? #{Wordy.anagram?(word1, word2)}"
end

check_anagram.('book', 'cook')
check_anagram.('rail safety', 'fairy tales')
check_anagram.('roast  beef', 'eat for bse')
check_anagram.('roast fest', 'eat for sal')
