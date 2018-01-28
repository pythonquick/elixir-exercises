# Basic mix usage notes

## Create new project

Use the `mix new <project>` command to create a new project. Example:

    mix new weather

# Running mix project

* One option, run the `mix run -e 'MyModules.run(["arg1", "arg2"])'` command on
  the terminal. This will call function `run` in module named `MyModules` with
  two string parameters.
* To interact with the application using iex, open iex with the `-s mix` option,
  like so: `iex -S mix`.

## Tests

### Test files

Tests are in the `<project>/test` directory.
Example template for a test file can be taken from the initial test file for the
project: `<project>/test/<project>_test.exs`

Example:

    defmodule WeatherTest do
        use ExUnit.Case
        doctest Weather

        test "greets the world" do
            assert Weather.hello() == :world
        end
    end

Note:
    * the `doctest` macro tests the documentation

### Running tests

Run all tests on the terminal using `mix test`

# Dependencies / Packages

Packages can be found on http://hex.pm

## List dependencies

Run the command `mix deps` to display the current dependencies of the mix
project.

## Add a dependency

To include a package to the mix project, add its name and version to the mix.exs
file in the deps function. Example:

  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      httpoison: "~> 1.0",
      poison: "~> 3.1",
      ex_doc: "~> 0.18.1",
      earmark: "~> 1.2"
    ]
  end

Next, run the `mix deps.get` command to download the package


# Configuration

When the `mix new <projectname>` command creates the file config/config.exs as
part of the project directory tree. This file starts with the line `use Mix.Config`. The next lines add configuration options per
application. Here is an example config.exs file:

    use Mix.Config
    config :issues, github_url: "https://api.github.com"
    config :logger, compile_time_purge_level: :info

the config macro adds one or more configuration options to an application.
The application name is the first argument and is the application name as an
atom. In the above example, one configuration option (github_url) is added to
the issues application, and the value is "https://api.github.com"

# Making an executable

Use the Erlang 'escript' utility to create an executable:

`mix escript.build`

# Create project documentation

Run `mix docs`
