defmodule Ticker do
  @name :ticker   # Ticker process name
  @interval 2000  # 2 seconds

  def start do
    ticker_pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, ticker_pid)
  end

  def register(client_pid) do
    server_pid = :global.whereis_name(@name)
    IO.puts "Registering client pid #{inspect client_pid} on #{inspect server_pid}"
    send server_pid, {:register, client_pid}
  end

  def generator(client_pids, counter \\ 0) do
    receive do
      {:register, client_pid} ->
        generator(client_pids ++ [client_pid], counter)
    after @interval ->
      IO.puts "tick #{counter}"
      send_tick_to_clients(client_pids, counter)
    end
  end

  def send_tick_to_clients(client_pids, counter) when client_pids == [] do
    generator(client_pids, counter + 1)
  end
  def send_tick_to_clients(client_pids, counter) do
      [next_client_pid | other_client_pids] = client_pids
      send next_client_pid, {:tick, counter}
      generator(other_client_pids ++ [next_client_pid], counter + 1)
  end
end


defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick, counter} ->
        IO.puts "Tickety tock! #{counter}"
        receiver()
    end
  end
end
