defmodule BugBot.UsersTest do
  use BugBot.DataCase

  alias BugBot.Users

  describe "users" do
    alias BugBot.Users.User

    @valid_attrs %{avatar_url: "some avatar_url", html_url: "some html_url", login: "some login", token: "some token"}
    @update_attrs %{avatar_url: "some updated avatar_url", html_url: "some updated html_url", login: "some updated login", token: "some updated token"}
    @invalid_attrs %{avatar_url: nil, html_url: nil, login: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.avatar_url == "some avatar_url"
      assert user.html_url == "some html_url"
      assert user.login == "some login"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.avatar_url == "some updated avatar_url"
      assert user.html_url == "some updated html_url"
      assert user.login == "some updated login"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  describe "users" do
    alias BugBot.Users.User

    @valid_attrs %{avatar_url: "some avatar_url", html_url: "some html_url", login: "some login", name: "some name", token: "some token"}
    @update_attrs %{avatar_url: "some updated avatar_url", html_url: "some updated html_url", login: "some updated login", name: "some updated name", token: "some updated token"}
    @invalid_attrs %{avatar_url: nil, html_url: nil, login: nil, name: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.avatar_url == "some avatar_url"
      assert user.html_url == "some html_url"
      assert user.login == "some login"
      assert user.name == "some name"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.avatar_url == "some updated avatar_url"
      assert user.html_url == "some updated html_url"
      assert user.login == "some updated login"
      assert user.name == "some updated name"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
