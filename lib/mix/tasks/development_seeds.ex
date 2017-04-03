defmodule Mix.Tasks.DevelopmentSeeds do
  use Mix.Task
  import Syndeo.Factory
  alias Syndeo.Repo
  alias Syndeo.User

  @doc "insert dev data"
  def run(_args) do
    Mix.Task.run "ecto.migrate", []
    Mix.Task.run "app.start", []

    for table_name <- tables_to_truncate() do
      Ecto.Adapters.SQL.query!(Repo, "TRUNCATE TABLE #{table_name} CASCADE")
    end

    build(:user, email: "admin@example.com", password: "password")
    |> save
    |> print

    [
      "John",
      "Simon Peter",
      "Andrew",
      "Thomas",
      "Philip",
      "Simon the Zealot",
      "Bartholomew",
      "Matthew",
      "Thaddeus",
      "James, son of Zebedee",
      "James, son of Alphaeus",
      "Judas",
    ] |> Enum.each(&create_attendee_with_week_info/1)
  end

  defp create_attendee_with_week_info(name) do
    insert(:attendee, name: name)
    |> insert_weekly_info()
  end

  defp insert_weekly_info(attendee) do
    insert(:weekly_info, attendee: attendee)
  end

  defp tables_to_truncate do
    ~w(
       attendees
       weeklyinfo
     )
  end

  defp print(%User{}=user) do
    IO.puts "User: #{user.email}/#{user.password}"
  end
end
