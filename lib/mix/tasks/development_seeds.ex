defmodule Mix.Tasks.DevelopmentSeeds do
  use Mix.Task
  import Syndeo.Factory
  alias Syndeo.Repo

  @doc "insert dev data"
  def run(_args) do
    Mix.Task.run "ecto.migrate", []
    Mix.Task.run "app.start", []

    for table_name <- tables_to_truncate() do
      Ecto.Adapters.SQL.query!(Repo, "TRUNCATE TABLE #{table_name} CASCADE")
    end

    insert(:attendee, name: "John")
    insert(:attendee, name: "Simon Peter")
    insert(:attendee, name: "Andrew")
    insert(:attendee, name: "Thomas")
    insert(:attendee, name: "Philip")
    insert(:attendee, name: "Simon the Zealot")
    insert(:attendee, name: "Bartholomew")
    insert(:attendee, name: "Matthew")
    insert(:attendee, name: "Thaddeus")
    insert(:attendee, name: "James, son of Zebedee")
    insert(:attendee, name: "James, son of Alphaeus")
    insert(:attendee, name: "Judas")
  end

  defp tables_to_truncate do
    ~w(
       attendees
       weeklyinfo
     )
  end
end
