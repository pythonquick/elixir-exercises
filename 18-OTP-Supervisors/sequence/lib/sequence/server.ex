defmodule Sequence.Server do
  use GenServer

  ##############################################################################
  # Client API:
  ##############################################################################

  def start_link(initial_state \\ 1) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.call(__MODULE__, {:increment_number, delta})
  end

  def error do
    GenServer.call(__MODULE__, :non_existent_function)
  end

  ##############################################################################
  # GenServer callbacks:
  ##############################################################################

  def handle_call(:next_number, _caller, state) do
    {:reply, state, state + 1}
  end

  def handle_call({:increment_number, delta}, _caller, state) do
    {:reply, :ok, state + delta}
  end
end
