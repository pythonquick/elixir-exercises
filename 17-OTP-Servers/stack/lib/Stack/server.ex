defmodule Stack.Server do
  use GenServer

  ##############################################################################
  # Client API:
  ##############################################################################

  def start(initial_stack \\ []) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def current do
    GenServer.call(__MODULE__, :current)
  end

  def push(newItem) when is_number(newItem) do
    GenServer.cast(__MODULE__, {:push, newItem})
  end

  def push(newItem) do
    GenServer.cast(__MODULE__, {:push, newItem})
  end


  ##############################################################################
  # GenServer callbacks:
  ##############################################################################

  def handle_call(:pop, _from, stack) when stack == [] do
    # pop on empty stack does nothing
    {:reply, None, stack}
  end

  def handle_call(:pop, _from, stack) do
    [head | tail] = stack
    {:reply, head, tail}
  end

  def handle_call(:current, _from, stack) do
    {:reply, stack, stack}
  end

  def handle_call(unhandled, _from, stack) do
    # Default call handler for unhandled request:
    IO.puts "Unhandled call:"
    IO.inspect unhandled
    {:reply, None, stack}
  end

  def handle_cast({:push, newItem}, stack) when is_number(newItem) do
    {:noreply, [newItem | stack]}
  end

  def handle_cast({:push, _newItem}, stack) do
    {:stop, "Cannot push non-number", stack}
  end

  def terminate(reason, state) do
    IO.puts "Terminating the server. Reason:"
    IO.puts "#{inspect reason}"
    IO.puts "State:"
    IO.puts "#{inspect state}"
  end
    
end
