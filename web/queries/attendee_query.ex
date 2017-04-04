defmodule Syndeo.AttendeeQuery do
  import Ecto.Query
  alias Syndeo.Repo
  alias Syndeo.Attendee
  alias Syndeo.WeeklyInfo

  def find_attendee!(id) do
    Attendee
    |> Repo.get!(id)
    |> Repo.preload([:weekly_info])
  end

  def find_attendees_with_current_week_info do
    Repo.all(Attendee)
    |> Repo.preload(weekly_info: (from w in WeeklyInfo, where: [week_date: ^current_week()]))
  end

  defp current_week do
    Timex.beginning_of_week(Timex.today, :sun)
  end
end
