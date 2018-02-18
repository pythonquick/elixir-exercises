defmodule Sequence.Client do
  def run do
    {:ok, pid} = GenServer.start_link(Sequence.Server, 100)
    IO.puts "pid is #{inspect pid}"
    IO.puts GenServer.call(pid, :next_number)
    IO.puts GenServer.call(pid, :next_number)
    IO.puts GenServer.call(pid, :next_number)
    IO.puts GenServer.call(pid, :next_number)
    pid
  end
end
