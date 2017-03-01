defmodule ConnectionCard.Plug.SessionBackdoor do
  alias ConnectionCard.Repo
  alias ConnectionCard.Attendee
  import ConnectionCard.AttendeeSession, only: [login_attendee: 2]

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
