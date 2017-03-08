defmodule Syndeo.WeeklyInfo do
  use Syndeo.Web, :model

  schema "weeklyinfo" do
    field :week_date, Timex.Ecto.Date
    field :attending_meal, :boolean, default: false
    field :num_kids, :integer
    field :num_teens, :integer
    field :num_adults, :integer
    field :prayers, :string
    field :contact, :string
    field :service, :string, default: "10:30"
    belongs_to :attendee, Syndeo.Attendee, type: :binary_id

    timestamps()
  end

  defp required_fields do
    ~w(
       attendee_id
       week_date
       attending_meal
       service
     )a
  end

  defp optional_fields do
    ~w(
       num_kids
       num_teens
       num_adults
       prayers
       contact
     )a
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_fields() ++ optional_fields())
    |> validate_required(required_fields())
  end

  def contact_options do
    [
      "Becoming a follower of Christ",
      "Church membership",
      "I'd like a visit or call from the pastor",
      "Serving at SMCC",
      "Other (Please specify in the comments section)"
    ]
  end

  def services do
    [
      "9:00",
      "10:30"
    ]
  end


  def week_of do
    Timex.beginning_of_week(Timex.today, :sun)
  end

end
