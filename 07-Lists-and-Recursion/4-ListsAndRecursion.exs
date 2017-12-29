defmodule MyList do
  def span(from, to) when from <= to do
    [from | span(from + 1, to)]
  end
  def span(_, _) do
    []
  end
end

from = 3
to = 24
IO.puts "From #{from} to #{to}:"
IO.puts "#{inspect MyList.span from, to}"
