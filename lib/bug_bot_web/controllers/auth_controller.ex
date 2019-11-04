defmodule BugBotWeb.AuthController do
  use BugBotWeb, :controller

  alias BugBot.Auth

  def authenticate(conn, _params) do
    redirect conn, external: Auth.authorize_url!(scope: "user, repo")
  end

  def delete(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "You have been logged out!")
    |> redirect(to: "/")
  end

  def callback(conn, %{"code" => code}) do
    client = Auth.get_token!(code: code)
    %{body: user} = OAuth2.Client.get!(client, "/user")

    token = client.token.access_token
    {:ok, user} = Jason.decode!(user)
    |> Map.put("token", token)
    |> BugBot.Users.create_user()

    IO.inspect(user)

    conn
    |> put_session(:user_id, user.id)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/welcome")
  end
end
