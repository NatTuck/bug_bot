defmodule BugBotWeb.IssueControllerTest do
  use BugBotWeb.ConnCase

  alias BugBot.Issues

  @create_attrs %{body: "some body", state: "some state", title: "some title", url: "some url"}
  @update_attrs %{body: "some updated body", state: "some updated state", title: "some updated title", url: "some updated url"}
  @invalid_attrs %{body: nil, state: nil, title: nil, url: nil}

  def fixture(:issue) do
    {:ok, issue} = Issues.create_issue(@create_attrs)
    issue
  end

  describe "index" do
    test "lists all issues", %{conn: conn} do
      conn = get(conn, Routes.issue_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Issues"
    end
  end

  describe "new issue" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.issue_path(conn, :new))
      assert html_response(conn, 200) =~ "New Issue"
    end
  end

  describe "create issue" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.issue_path(conn, :create), issue: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.issue_path(conn, :show, id)

      conn = get(conn, Routes.issue_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Issue"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.issue_path(conn, :create), issue: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Issue"
    end
  end

  describe "edit issue" do
    setup [:create_issue]

    test "renders form for editing chosen issue", %{conn: conn, issue: issue} do
      conn = get(conn, Routes.issue_path(conn, :edit, issue))
      assert html_response(conn, 200) =~ "Edit Issue"
    end
  end

  describe "update issue" do
    setup [:create_issue]

    test "redirects when data is valid", %{conn: conn, issue: issue} do
      conn = put(conn, Routes.issue_path(conn, :update, issue), issue: @update_attrs)
      assert redirected_to(conn) == Routes.issue_path(conn, :show, issue)

      conn = get(conn, Routes.issue_path(conn, :show, issue))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, issue: issue} do
      conn = put(conn, Routes.issue_path(conn, :update, issue), issue: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Issue"
    end
  end

  describe "delete issue" do
    setup [:create_issue]

    test "deletes chosen issue", %{conn: conn, issue: issue} do
      conn = delete(conn, Routes.issue_path(conn, :delete, issue))
      assert redirected_to(conn) == Routes.issue_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.issue_path(conn, :show, issue))
      end
    end
  end

  defp create_issue(_) do
    issue = fixture(:issue)
    {:ok, issue: issue}
  end
end
