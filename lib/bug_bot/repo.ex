defmodule BugBot.Repo do
  use Ecto.Repo,
    otp_app: :bug_bot,
    adapter: Ecto.Adapters.Postgres
end
