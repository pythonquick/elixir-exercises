defmodule RingClient do
  @timeout 2000

  @doc """
  The only function an external client should call to join the ring.
  """
  def start do
    current_pid = :global.whereis_name(:current)
    spawn(__MODULE__, :startup, [current_pid])
  end


  # Start up the client if there's no current client on the ring.
  # This means, the client is the first one! We form a closed ring pointing
  # to the same node
  def startup(current_pid) when current_pid == :undefined do
    my_pid = self()
    :global.register_name(:current, my_pid)
    receiver(my_pid)
  end


  # Start up the client and join an existing ring by sending the active ring node
  # a message to register the new client
  def startup(current_pid) do
    my_pid = self()
    send current_pid, {:register, my_pid}
    wait_for_hookup()
  end


  # Upon joining an existing ring, wait to be hooked up
  def wait_for_hookup do
    receive do
      {:hookup, next_pid} ->
        receiver(next_pid)
    end
  end


  # Start the receive loop
  def receiver(next_pid, counter \\ 1) do
    receive do
      # Register a new client by inserting it into the ring:
      {:register, new_pid} ->
        send new_pid, {:hookup, next_pid}
        receiver(new_pid, counter)

      # Tick message received! Only the node after the current/active one
      # receives a Tick, making that the new current node:
      {:tick} ->
        my_pid = self()
        :global.re_register_name(:current, my_pid)
        IO.puts "TICK! #{counter}"
        receiver(next_pid, counter+1)

      # Timeout: this is the heartbeat. Send Tick message to next node if
      # we're the current node
      after @timeout ->
        current_pid = :global.whereis_name(:current)
        my_pid = self()
        if my_pid == current_pid do
          send next_pid, {:tick}
        end
        receiver(next_pid, counter)
    end
  end
end
