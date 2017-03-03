defmodule Syndeo.Repo.Migrations.CreateMeal do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :description, :string
      add :date, :date

      timestamps()
    end

  end
end
