defmodule Stack do
  use GenServer

  def start_link(stash_pid) do
    IO.puts "Stack start_link"
    initial_value = GenServer.call(stash_pid, :current)
    GenServer.start_link(__MODULE__, {stash_pid, initial_value}, name: __MODULE__)
  end

  def pop, do: GenServer.call(__MODULE__, :pop)

  def push(value), do: GenServer.cast(__MODULE__, {:push, value})

  def current, do: GenServer.call(__MODULE__, :current)

  def error do
    GenServer.call(__MODULE__, :bla)
  end

  ##############################################################################
  # GenServer functions:
  ##############################################################################

  def handle_call(:pop, _caller, {stash_pid, stack}) do
    [head | tail] = stack
    {:reply, head, {stash_pid, tail}}
  end

  def handle_call(:current, _caller, {stash_pid, stack}) do
    {:reply, stack, {stash_pid, stack}}
  end

  def handle_cast({:push, value}, {stash_pid, stack}) do
    {:noreply, {stash_pid, [value | stack]}}
  end

  def terminate(_reason, state) do
    # Something bad happened, and this working is terminating.
    # Save current state in the Stack.Stash
    {stash_pid, stack} = state
    GenServer.cast(stash_pid, {:apply, stack})
  end
end
