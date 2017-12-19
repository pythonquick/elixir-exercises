defmodule Library do
  def float_to_str float_number, num_decimals \\ 2 do
    :io.format("~.#{num_decimals}f~n", [float_number])
  end


  def env_param name do
    System.get_env name
  end


  def file_extension file_name do
    Path.extname file_name
  end


  def process_dir do
    System.cwd
  end


  def exec cmd, args \\ [] do
    {output, _} = System.cmd cmd, args
    output
  end
end

IO.puts "1. Convert a float to a string using Erlang:"
IO.puts "pi is"
IO.puts Library.float_to_str(3.14159)
IO.puts ""
IO.puts "2. Get value of OS environment variable using Elixir:"
IO.puts "PATH varable is:"
IO.puts Library.env_param "PATH"
IO.puts ""
IO.puts "3. Get file extension"
IO.puts "Extension for python.exe is:"
IO.puts Library.file_extension "python.exe"
IO.puts ""
IO.puts "4. Get current process's working directory:"
IO.puts Library.process_dir
IO.puts ""
# 5. Convert JSON into Elixir data structure using the 'poison library:
#    https://github.com/devinus/poison
IO.puts "6. Run OS command"
IO.puts "pwd"
IO.puts Library.exec "pwd"
IO.puts "ls -al /"
IO.puts Library.exec "ls", ["-al", "/Users"]
