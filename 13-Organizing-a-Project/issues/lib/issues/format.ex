defmodule Issues.Format do
  def column_lengths(issues, columns) do
    Enum.reduce(columns, [], fn(column, acc) ->
      max_length = find_max_length(issues, column)
      [max_length | acc]
    end)
    |> Enum.reverse
  end

  def draw_table(issues, columns) do
    column_lengths = column_lengths(issues, columns)
    draw_single_row_columns(Enum.zip(columns, column_lengths), " | ")
    heading_separators = Enum.map(column_lengths, &(String.duplicate("-", &1)))
    draw_single_row_columns(Enum.zip(heading_separators, column_lengths), "-+-")
    Enum.each(issues, fn(issue) ->
      column_values = Enum.map(columns, &(Map.get(issue, &1)))
      draw_single_row_columns(Enum.zip(column_values, column_lengths), " | ")
    end)
  end

  defp draw_single_row_columns(cells_to_draw, separator) do
    IO.puts Enum.map_join(cells_to_draw, separator, fn({content, length}) ->
      String.pad_trailing(stringify(content), length)
    end)
  end

  defp find_max_length(issues, column) do
    issues
    |> Enum.map(&(Map.get(&1, column)))
    |> Enum.map(&stringify/1)
    |> Enum.map(&String.length/1)
    |> Enum.max
  end


  defp stringify(arg) when is_binary(arg), do: arg
  defp stringify(arg) when is_integer(arg), do: Integer.to_string(arg)
end
