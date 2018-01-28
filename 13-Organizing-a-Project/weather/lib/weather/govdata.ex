defmodule Weather.GovData do
  import SweetXml

  @weather_base_url Application.get_env(:weather, :weather_gov_base_url)
  @field_titles %{
      station: "Station",
      temp_c: "Degrees Celcius",
      temp_f: "Degrees Fahrenheit",
      observation_time: "Time"
  }

  def fetch(observationCode) do
    HTTPoison.get("#{@weather_base_url}/#{observationCode}.xml")
  end


  def processData({:ok, %{body: body}}) do
    body |> SweetXml.xpath(
      ~x"//current_observation",
      station: ~x"./station_id/text()",
      temp_c: ~x"./temp_c/text()",
      temp_f: ~x"./temp_f/text()",
      observation_time: ~x"./observation_time/text()"
    )
  end


  def processData({_, _}) do
    IO.puts "Could not process weather data"
  end


  def title_value_rows(weatherConditions) do
    add_title_value_row([], weatherConditions, Map.keys(weatherConditions))
  end

  defp add_title_value_row(rows, weatherConditions, [key | remaining_keys]) do
    row = {@field_titles[key], Map.get(weatherConditions, key)}
    add_title_value_row([row | rows], weatherConditions, remaining_keys)
  end


  defp add_title_value_row(rows, _, []) do
    rows
  end


end
