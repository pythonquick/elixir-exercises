defmodule SpawnMessage do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Greetings, #{msg}"}
        greet
    end
  end
end


# Client:
pid = spawn(SpawnMessage, :greet, [])
send pid, {self(), "Guenther"}

receive do
  {:ok, message} -> IO.puts "Received message: #{message}"
end
send pid, {self(), "Adolfo"}
receive do
  {:ok, message} -> IO.puts "Received message: #{message}"
after 500 ->
  IO.puts "greeter has left"
end
send pid, {self(), "Peters"}
receive do
  {:ok, message} -> IO.puts "Received message: #{message}"
after 500 -> IO.puts "greeter has left"
end

