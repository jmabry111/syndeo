defmodule Syndeo.Plug.SessionBackdoor do
  alias Syndeo.Repo
  alias Syndeo.Attendee
  import Syndeo.AttendeeSession, only: [login_attendee: 2]

  def init(default), do: default

  def call(conn, _default) do
    case conn.query_params do
      %{"as_contact" => id} ->
        attendee = Repo.get!(Attendee, id)
        conn
        |> login_attendee(attendee)
      _ -> conn
    end
  end
end
