defmodule Mix.Tasks.DevelopmentSeeds do
  use Mix.Task
  alias ConnectionCard.Repo

  @doc "insert dev data"
  def run(_args) do
    Mix.Task.run "ecto.migrate", []
    Mix.Task.run "app.start", []

    for table_name <- tables_to_truncate() do
      Ecto.Adapters.SQL.query!(Repo, "TRUNCATE TABLE #{table_name} CASCADE")
    end
  end

  defp tables_to_truncate do
    ~w(
       attendees
       weekly_info
     )
  end
end
