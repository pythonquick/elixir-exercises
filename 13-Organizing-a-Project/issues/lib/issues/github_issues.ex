defmodule Issues.GitHubIssues do
  require Logger
  @http_options ["User-agent": "Elixir Query Program"]
  @github_url Application.get_env(:issues, :github_url)

  @doc """
  for given GitHub user and project (repo), return the issues page content.
  Return either:
    {:ok, data} if content could be loaded, or
    {:error, response} if content could not be loaded successfully
  """
  def fetch(user, project) do
    gitHubIssuesURL(user, project)
    |> HTTPoison.get(@http_options)
    |> handle_response
  end


  defp gitHubIssuesURL(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end


  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.info "Data fetch OK."
    {:ok, Poison.Parser.parse!(body)}
  end


  defp handle_response({_, %{status_code: _, body: body}}) do
    Logger.info "Data fetch NOT ok."
    {:error, Poison.Parser.parse!(body)}
  end
end
