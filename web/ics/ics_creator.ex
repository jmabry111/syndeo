defmodule Syndeo.IcsCreator do

  def create_ics(date, description) do
    events = [
      %ICalendar.Event{
        summary: "Wednesday night meal",
        dtstart: start_time(date),
        dtend: end_time(date),
        description: "Come enjoy some #{description} with us.",
        location: "3030 Virginia Ave, Collinsville, VA",
      },
    ]
    %ICalendar{ events: events } |> ICalendar.to_ics
  end

  defp start_time(date) do
    date
    |> Timex.to_datetime("America/New_York")
    |> Timex.shift(hours: 17, minutes: 30)
  end
  defp end_time(date) do
    date
    |> Timex.to_datetime("America/New_York")
    |> Timex.shift(hours: 19, minutes: 00)
  end
end
