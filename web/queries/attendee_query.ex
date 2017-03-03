defmodule Syndeo.AttendeeQuery do
  alias Syndeo.Repo
  alias Syndeo.Attendee

  def find_attendee!(id) do
    Attendee
    |> Repo.get!(id)
    |> Repo.preload([:weekly_info])
  end
end
