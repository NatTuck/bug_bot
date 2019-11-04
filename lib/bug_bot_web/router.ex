defmodule BugBotWeb.Router do
  use BugBotWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BugBotWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/welcome", PageController, :welcome
    resources "/users", UserController

    # Oauth2 Authentication
    get "/auth", AuthController, :authenticate
    delete "/auth", AuthController, :delete
    get "/auth/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", BugBotWeb do
  #   pipe_through :api
  # end
end
