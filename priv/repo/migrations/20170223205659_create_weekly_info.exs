defmodule Syndeo.Repo.Migrations.CreateWeeklyInfo do
  use Ecto.Migration

  def change do
    create table(:weeklyinfo) do
      add :week_date, :date
      add :attending_meal, :boolean, default: false, null: false
      add :num_kids, :integer
      add :num_teens, :integer
      add :num_adults, :integer
      add :prayers, :string
      add :contact, :string
      add :attendee_id, references(:attendees, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:weeklyinfo, [:attendee_id])

  end
end
