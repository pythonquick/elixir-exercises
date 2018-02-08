defmodule Spawnly do
  def sender(pid) do
    send pid, "You betcha"
    exit(:WeAreDone)
  end

  def keepReceivingMessages do
    receive do
      msg -> IO.puts "Received message: #{inspect msg}"
    end
    keepReceivingMessages()
  end

  def run do
    {_pid, _ref} = spawn_monitor(Spawnly, :sender, [self()])
    :timer.sleep(500) # sleep for half second

    # with spawn_monitor, we'll receive the regular message 
    # and then the DOWN message
    keepReceivingMessages()
  end
end

