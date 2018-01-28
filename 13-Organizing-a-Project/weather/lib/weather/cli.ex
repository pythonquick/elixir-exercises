defmodule Weather.CLI do
  import Weather.GovData


  def run(observationCode \\ 'KBVY') do
    observationCode
    |> Weather.GovData.fetch
    |> Weather.GovData.processData
    |> Weather.GovData.title_value_rows
    |> displayWeatherCondition
  end


  defp displayWeatherCondition(weather_field_rows) do
    IO.puts "Weather Conditions:"
    IO.puts "==================="
    IO.puts ""
    Enum.each(weather_field_rows, fn({title, value}) ->
      IO.puts "#{title}: #{value}"
    end)
  end
end
