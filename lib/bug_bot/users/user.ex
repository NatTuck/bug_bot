defmodule BugBot.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar_url, :string
    field :html_url, :string
    field :login, :string
    field :name, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :name, :avatar_url, :html_url, :token])
    |> validate_required([:login, :name, :avatar_url, :html_url, :token])
    |> unique_constraint(:login)
  end
end
