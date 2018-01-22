defmodule IssuesFormatTest do
  use ExUnit.Case
  doctest Issues.Format

  import Issues.Format, only: [
    column_length_map: 2
  ]

  test "determine column lenths" do
    issues = [
      %{"id" => 123, "title" => "one two three"},
      %{"id" => 2, "title" => "short"},
      %{"id" => 2343, "title" => "this is a long title line ok. ok."}
    ]
    column_lengths = column_length_map(issues, ["id", "title"])
    assert column_lengths == %{"id" => 4, "title" => 33}
  end

end
