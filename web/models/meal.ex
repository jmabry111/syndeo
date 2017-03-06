defmodule Syndeo.Meal do
  use Syndeo.Web, :model

  schema "meals" do
    field :description, :string
    field :date, Timex.Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :date])
    |> validate_required([:description, :date])
  end


  def find_wed do
    Timex.end_of_week(Timex.today, :thu)
  end
end
