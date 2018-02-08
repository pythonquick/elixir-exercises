defmodule Spawnly do
  def sender(pid) do
    send pid, "You betcha"
    raise "We are doomed"
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
    # and then the DOWN message.
    # But unlike the version with `exit`, when raising an exception we additionally
    # get the trace information on the console and as part of the DOWN message
    keepReceivingMessages()
  end
end


