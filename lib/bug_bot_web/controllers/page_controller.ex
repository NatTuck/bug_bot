defmodule BugBotWeb.PageController do
  use BugBotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
