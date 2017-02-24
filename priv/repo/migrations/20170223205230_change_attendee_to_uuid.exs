defmodule ConnectionCard.Repo.Migrations.ChangeAttendeeToUuid do
  use Ecto.Migration

  def change do
    Ecto.Adapters.SQL.query(ConnectionCard.Repo, "TRUNCATE TABLE attendees CASCADE")

    alter table(:attendees) do
      remove :id
      add :id, :binary_id, primary_key: true
    end
  end
end
