defmodule BugBot.Issues.Issue do
  defstruct id: -1, number: -1, html_url: "", state: "", title: "", body: ""

  @types %{
    id: :integer,
    number: :integer,
    html_url: :string,
    state: :string,
    title: :string,
    body: :string,
  }

  def new(attrs) do
    Enum.map(Map.keys(@types), fn key ->
      {key, Map.get(attrs, to_string(key))}
    end)
    |> Enum.into(%{})
    |> Map.put(:__struct__, __MODULE__)
  end

  def changeset(issue, attrs \\ %{}) do
    {issue, @types}
    |> Ecto.Changeset.cast(attrs, Map.keys(@types))
  end
end
