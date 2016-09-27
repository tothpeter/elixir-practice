defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir hello@kalina.tech"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get!(@user_agent)
    |> IO.inspect
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response(%{status_code: 200, body: body}), do: { :ok,    body }
  def handle_response(%{status_code: ___, body: body}), do: { :error, body }
end
