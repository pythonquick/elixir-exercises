defmodule Stack.Stash do
  use GenServer

  def start_link(initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  ##############################################################################
  # GenServer functions:
  ##############################################################################

  def handle_call(:current, _caller, current_value) do
    {:reply, current_value, current_value}
  end

  def handle_cast({:apply, value}, _current_value) do
    {:noreply, value}
  end
end
