defmodule Library do
  def float_to_str float_number, num_decimals \\ 2 do
    :io.format("~.#{num_decimals}f~n", [float_number])
  end
end


IO.puts "pi is"
IO.puts Library.float_to_str(3.14159)
