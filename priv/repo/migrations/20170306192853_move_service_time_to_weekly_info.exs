defmodule Syndeo.Repo.Migrations.MoveServiceTimeToWeeklyInfo do
  use Ecto.Migration

  def change do

    alter table(:attendees) do
      remove :service
    end

    alter table(:weeklyinfo) do
      add :service, :string, null: false
    end
  end
end
