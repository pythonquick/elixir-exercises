defmodule IssuesCLITest do
  use ExUnit.Case
  doctest Issues.CLI

  import Issues.CLI, only: [
    parse_args: 1,
    sort_issues_ascending: 1
  ]

  test ":help returned when using -h or --help switches" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help"]) == :help
  end

  test "Return user, project, count options" do
    assert parse_args(["pythonquick", "elixir", "3"]) == {"pythonquick", "elixir", 3}
  end

  test "Return user, project and default count 4 of no count provided" do
    assert parse_args(["pythonquick", "elixir"]) == {"pythonquick", "elixir", 4}
  end

  test "correct ascended sort order for issues" do
    issues =
      create_fake_list(["c", "a", "b"])
      |> sort_issues_ascending
      |> Enum.map(&(Map.get(&1, "created_at")))
    assert issues == ["a", "b", "c"]
  end

  defp create_fake_list(items) do
    Enum.map(items, &(%{"created_at" => &1, "other_data" => "bla"}))
  end
end
