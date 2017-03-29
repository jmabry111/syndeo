defmodule Syndeo.Plug.SessionBackdoor do
  alias Syndeo.Repo
  alias Syndeo.User
  alias Syndeo.Attendee
  import Doorman.Login.Session
  import Syndeo.AttendeeSession, only: [login_attendee: 2]

  def init(default), do: default

  def call(conn, _default) do
    case conn.query_params do
      %{"as" => id} ->
        user = Repo.get!(User, id)
        conn
        |> login(user)
      %{"as_contact" => id} ->
        attendee = Repo.get!(Attendee, id)
        conn
        |> login_attendee(attendee)
      _ -> conn
    end
  end
end
