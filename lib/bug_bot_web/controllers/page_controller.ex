defmodule BugBotWeb.PageController do
  use BugBotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def welcome(conn, _params) do
    user = BugBot.Users.get_user!(get_session(conn, :user_id))
    render(conn, "welcome.html", user: user)
  end
end
