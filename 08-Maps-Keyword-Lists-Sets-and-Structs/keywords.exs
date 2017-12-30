defmodule Canvas do
  @defaults [bg: "black", font: "Meriweather"]
  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text \"#{text}\""
    IO.puts "Foreground:  #{Keyword.get(options, :fg)}"
    IO.puts "Background:  #{Keyword.get(options, :bg)}"
    IO.puts "Font:        #{Keyword.get(options, :font)}"
    IO.puts "Pattern:     #{Keyword.get(options, :pattern, "Solid")}"
    IO.puts "Style:       #{inspect Keyword.get_values(options, :style)}"
  end
end


Canvas.draw_text("hello", fg: "red", style: "italic", style: "bold")

# =>
# Drawing text "hello"
# Foreground:  red
# Background:  white
# Font:        Merriweather
# Pattern:     solid
# Style:       ["italic", "bold"]
