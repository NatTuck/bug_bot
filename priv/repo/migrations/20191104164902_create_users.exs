defmodule BugBot.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string, null: false
      add :name, :string, null: false
      add :avatar_url, :string
      add :html_url, :string
      add :token, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:login])
  end
end
