defmodule Stack.Supervisor do
  use Supervisor

  def start_link() do
    result = DynamicSupervisor.start_link(strategy: :one_for_one, name: __MODULE__)

    # Start and supervise the Stash worker:
    {:ok, stash_pid} = DynamicSupervisor.start_child(
      __MODULE__,
      %{
        id: Stack.Stash,
        start: {Stack.Stash, :start_link, [[11, 22]]}
      }
    )

    # Start and supervise the sub-supervisor that will supervise the Stack:
    DynamicSupervisor.start_child(
      __MODULE__,
      %{
        id: Stack.Subsupervisor,
        start: {Stack.Subsupervisor, :start_link, [stash_pid]}
      }
    )

    result
  end
end
