defmodule Stack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts "Application start"
    Stack.Supervisor.start_link()
  end
end
