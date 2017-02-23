defmodule ConnectionCard.Repo.Migrations.CreateWeeklyInfo do
  use Ecto.Migration

  def change do
    create table(:weeklyinfo) do
      add :week_date, :date
      add :attending_meal, :boolean, default: false, null: false
      add :num_kids, :integer
      add :num_teens, :integer
      add :num_adults, :integer
      add :prayers, :string
      add :contact, :boolean, default: false, null: false
      add :attendee_id, references(:attendee, on_delete: :nothing)

      timestamps()
    end
    create index(:weeklyinfo, [:attendee_id])

  end
end
