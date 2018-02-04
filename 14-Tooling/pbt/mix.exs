defmodule Pbt.MixProject do
  use Mix.Project

  def project do
    [
      app: :pbt,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,

      # Add following for coveralls, (see dependency :execoveralls)
      # This allows us to run `mix coveralls` to determine test coverage
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],

      deps: deps(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :excheck, "~> 0.5.0", only: :test},
      { :triq, github: "triqng/triq", only: :test},
      { :excoveralls, "~> 0.5", only: :test}
    ]
  end
end
