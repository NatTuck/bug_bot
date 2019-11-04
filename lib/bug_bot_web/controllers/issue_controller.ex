defmodule BugBotWeb.IssueController do
  use BugBotWeb, :controller

  alias BugBot.Issues
  alias BugBot.Issues.Issue

  plug :create_client

  def create_client(conn, _params) do
    user = BugBot.Users.get_user!(get_session(conn, :user_id))
    client = BugBot.Auth.new(user.token)
    assign(conn, :client, client)
  end

  def index(conn, _params) do
    issues = Issues.list_issues(conn.assigns[:client])
    render(conn, "index.html", issues: issues)
  end

  def new(conn, _params) do
    changeset = Issues.change_issue(%Issue{})
    render(conn, "new.html", changeset: changeset, me: "post")
  end

  def create(conn, %{"issue" => issue_params}) do
    case Issues.create_issue(conn.assigns[:client], issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue created successfully.")
        |> redirect(to: Routes.issue_path(conn, :show, issue.number))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Issues.get_issue!(conn.assigns[:client], id)
    render(conn, "show.html", issue: issue)
  end

  def edit(conn, %{"id" => id}) do
    issue = Issues.get_issue!(conn.assigns[:client], id)
    changeset = Issues.change_issue(issue)
    render(conn, "edit.html", issue: issue, changeset: changeset, me: "put")
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    client = conn.assigns[:client]
    issue = Issues.get_issue!(client, id)

    case Issues.update_issue(client, issue.number, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue updated successfully.")
        |> redirect(to: Routes.issue_path(conn, :show, issue.number))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", issue: issue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = conn.assigns[:client]
    issue = Issues.get_issue!(client, id)
    {:ok, _issue} = Issues.delete_issue(client, issue)

    conn
    |> put_flash(:info, "Issue closed successfully.")
    |> redirect(to: Routes.issue_path(conn, :index))
  end
end
