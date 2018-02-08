defmodule Spawnly do
  def sender(pid) do
    send pid, "You betcha"
    raise "We are doomed"
  end

  def keepReceivingMessages do
    receive do
      msg -> IO.puts "Received message: #{msg}"
    end
    keepReceivingMessages()
  end

  def run do
    _pid = spawn_link(Spawnly, :sender, [self()])
    :timer.sleep(500) # sleep for half second

    # The message we'll receive is the one about the spawned process dying
    # even though a regular message was sent before proceess exited.
    keepReceivingMessages()
  end
end

