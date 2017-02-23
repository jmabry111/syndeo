defmodule ConnectionCard.WeeklyInfo do
  use ConnectionCard.Web, :model

  schema "weeklyinfo" do
    field :week_date, Timex.Ecto.Date
    field :attending_meal, :boolean, default: false
    field :num_kids, :integer
    field :num_teens, :integer
    field :num_adults, :integer
    field :prayers, :string
    field :contact, :boolean, default: false
    belongs_to :attendee, ConnectionCard.Attendee

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:week_date, :attending_meal, :num_kids, :num_teens, :num_adults, :prayers, :contact])
    |> validate_required([:week_date, :attending_meal, :num_kids, :num_teens, :num_adults, :prayers, :contact])
  end
end
