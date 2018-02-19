defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts "supervisor applicaiton start"

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Sequence.Server.start_link(arg)
      {Sequence.Server, 40}

      # alternative:
      
      #%{
      #  id: Sequence.Server,
      #  start: {Sequence.Server, :start_link, [20]}
      #}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sequence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
