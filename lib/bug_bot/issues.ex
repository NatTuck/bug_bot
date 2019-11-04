defmodule BugBot.Issues do

  alias BugBot.Issues.Issue

  @base_url "/repos/NatTuck/bug_bot/issues"

  def list_issues(client) do
    %{body: body} = OAuth2.Client.get!(client, @base_url)
    Jason.decode!(body)
    |> Enum.map(&Issue.new/1)
  end

  def get_issue!(client, id) do
    %{body: body} = OAuth2.Client.get!(client, "#{@base_url}/#{id}")
    Jason.decode!(body)
    |> Issue.new()
  end

  def create_issue(client, params) do
    req_body = Jason.encode!(params)
    %{body: body} = OAuth2.Client.post!(client, @base_url, req_body)
    issue = Jason.decode!(body)
    |> Issue.new()
    {:ok, issue}
  end

  def update_issue(client, id, params) do
    req_body = Jason.encode!(params)
    %{body: body} = OAuth2.Client.patch!(
      client,
      "#{@base_url}/#{id}",
      req_body
    )
    issue = Jason.decode!(body)
    |> Issue.new()
    {:ok, issue}
  end

  def delete_issue(client, issue) do
    update_issue(client, issue.number, %{"state" => "closed"})
  end

  def change_issue(%Issue{} = issue, attrs \\ %{}) do
    Issue.changeset(issue, attrs)
  end
end
