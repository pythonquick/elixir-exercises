defmodule Stack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts "Application start"
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Stack.Worker.start_link(arg)
      # {Stack.Worker, arg},
      %{id: Stack.Worker, start: {Stack.Worker, :start_link, [[]]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    #opts = [strategy: :one_for_one, name: Stack.Supervisor]
    # Supervisor.start_link([], opts)
    Stack.Supervisor.start_link()
  end
end
