defmodule Syndeo.Repo.Migrations.CreateAttendee do
  use Ecto.Migration

  def change do
    create table(:attendees) do
      add :service, :string, null: false
      add :name, :string, null: false
      add :street, :string
      add :city, :string, null: false
      add :state, :string, null: false
      add :zip, :string
      add :email, :string, null: false
      add :phone, :string
      add :sms, :boolean, default: false, null: false
      add :membership_status, :string, null: false
      add :age_range, :string

      timestamps()
    end

    create unique_index(:attendees, [:email])
  end
end
