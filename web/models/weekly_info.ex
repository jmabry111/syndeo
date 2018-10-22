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
    field :service, :string
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
      "10:30"
    ]
  end

  def display_last_sunday do
    Timex.format!(
    Timex.beginning_of_week(Timex.today, :sun),
    "%m-%d-%Y",
    :strftime
  )
  end

  def week_of do
    today = Timex.today
    lastsun = Timex.beginning_of_week(Timex.today, :sun)
    nextsun = Timex.beginning_of_week(Timex.shift(today, days: 7), :sun)

    if Timex.diff(today, lastsun, :days) < 4 do
      lastsun
    else
      nextsun
    end
  end
end
