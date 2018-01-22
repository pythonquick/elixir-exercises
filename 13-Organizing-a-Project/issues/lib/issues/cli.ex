defmodule Issues.CLI do
  import Issues.Format, only: [
    draw_table: 2
  ]


  @default_issues_count 4
  @moduledoc """
  Provide Command-Line parser
  """


  @doc """
  run the app from command params passed
  """
  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end


  def process(:help) do
    IO.puts """
    usage:
        issues -h | --help
        issues <user> <repo> [count | 4]
    """
  end


  def process({user, repo, _count}) do
    Issues.GitHubIssues.fetch(user, repo)
    |> decode_GitHubResponse
    #    |> map_issues
    |> sort_issues_ascending
    |> take_first_few(5) # instead of Enum.take. Just for the fun of it.
    |> draw_table(["id", "title", "created_at"])

    |> IO.inspect
  end


  @doc """
  Parse command line options, providing defaults where appropriate

  `argv` can be -h or --help in which case it returns :help

  In other cases, expected arguments are:
  1. GitHub username
  2. GitHub repo
  3. Count (integer) of issues. Optional. Defaults to 4

  Returns a tuple of {user, repo, issue_count}
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse do
      {[help: true], _, _} -> :help
      {_, [user, repo, issue_count], _} -> {user, repo, String.to_integer(issue_count)}
      {_, [user, repo], _} -> {user, repo, @default_issues_count}
      _ -> :help
    end
  end


  defp decode_GitHubResponse({:ok, body}), do: body
  defp decode_GitHubResponse({:error, body}) do
    %{"message" =>  message} = body
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end


  #defp map_issues(github_issues) do
  #  github_issues
  #  |> Enum.map(fn (%{"id" => id, "title" => title, "created_at" => created_at}) ->
  #    %{created_at: created_at, id: id, title: title}
  #  end)
  #end


  def sort_issues_ascending(github_issues) do
    Enum.sort github_issues, fn left, right -> Map.get(left, "created_at") <= Map.get(right, "created_at") end
  end


  defp take_first_few([first_issue|remaining_issues], count) when count > 0 do
    [first_issue | take_first_few(remaining_issues, count-1)]
  end
  defp take_first_few([], _count) do
    []
  end
  defp take_first_few(_list, count) when count <= 0 do
    []
  end
end
