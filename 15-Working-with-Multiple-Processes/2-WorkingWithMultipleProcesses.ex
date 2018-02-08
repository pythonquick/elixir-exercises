defmodule Processes do
  def processOne do
    receive do
      {pid, token} -> send pid, {:processOne, token}
    end
    processOne()
  end

  def processTwo do
    receive do
      {pid, token} -> send pid, {:processTwo, token}
    end
    processTwo()
  end

  def processThree do
    receive do
      {pid, token} -> send pid, {token}
    end
    processThree()
  end

  def receiveMessage do
    receive do
      {:processOne, token} -> IO.puts "Received from process one: #{token}"
      {:processTwo, token} -> IO.puts "Received from process two: #{token}"
      x -> IO.puts "Received from another process: #{inspect x}"
    after 500 ->
      IO.puts "Timeout"
    end
  end

  def run do
    p2 = spawn(Processes, :processTwo, [])
    p1 = spawn(Processes, :processOne, [])
    p3 = spawn(Processes, :processThree, [])

    send p3, {self(), "Tripple"}
    send p1, {self(), "Unique"}
    send p2, {self(), "Double"}

    receiveMessage()
    receiveMessage()
    receiveMessage()

    send p3, {self(), "THREE"}
    send p1, {self(), "ONE"}
    send p2, {self(), "TWO"}

    receiveMessage()
    receiveMessage()
    receiveMessage()

  end
end
