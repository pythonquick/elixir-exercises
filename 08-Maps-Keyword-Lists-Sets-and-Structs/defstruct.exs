defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true

  def print_label(subbie = %Subscriber{}) do
    IO.puts "#{subbie.name}, is over 18? #{subbie.over_18 && "yes!" || "no!"}"
  end
end

defmodule Main do
  def main do
    slave = %Subscriber{name: "Alexa"}
    IO.puts Subscriber.print_label(slave)
  end
end


Main.main
