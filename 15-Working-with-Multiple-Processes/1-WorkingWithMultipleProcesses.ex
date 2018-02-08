defmodule Chain do
  def count(next_pid) do
    receive do
      n -> send next_pid, n+1
    end
  end

  def setupAndRunChain(chainLength) do
    last_pid = Enum.reduce(1..chainLength, self(), fn(_, pid) ->
      spawn(Chain, :count, [pid])
    end)

    send last_pid, 0

    receive do
      result -> IO.puts "Final result is #{result}"
    end
  end

  def run(chainLength) do
    {microseconds, :ok} = :timer.tc(Chain, :setupAndRunChain, [chainLength])
    IO.puts "It took #{microseconds / 1000000} seconds to chain #{chainLength} processes"
  end
end
