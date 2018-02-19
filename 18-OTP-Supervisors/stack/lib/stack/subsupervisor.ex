defmodule Stack.Subsupervisor do
  use Supervisor

  def start_link(stash_pid) do
    children = [
      %{
        id: Stack,
        start: {Stack, :start_link, [stash_pid]}
      }
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
