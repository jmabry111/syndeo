defmodule ConnectionCard.AttendeeSession do
  import Plug.Conn
  alias ConnectionCard.Attendee
  alias ConnectionCard.Endpoint
  alias ConnectionCard.Repo
  alias Phoenix.Token
  @twenty_four_hours 86400

  def init(default), do: default

  def call(conn, _default) do
    case get_session(conn, :current_attendee) do
      nil ->
        conn
      id ->
        case Attendee |> Repo.get(id) do
          nil ->
            conn
            |> delete_session(:current_attendee)
          attendee ->
            conn
            |> login_attendee(attendee)
        end
    end
  end

  def login_attendee(conn, %Attendee{}=attendee) do
    attendee =
      attendee
      |> Repo.preload([:weekly_info])
    conn
    |> assign(:current_attendee, attendee)
    |> put_session(:current_attendee, attendee.id)
  end

  def login_attendee(conn, id) do
    attendee = Attendee |> Repo.get(id)
    login_attendee(conn, attendee)
  end

  def generate_token(attendee) do
    Endpoint
    |> Token.sign("attendee", attendee.id)
  end

  def verify_token(token) do
    Endpoint
    |> Token.verify("attendee", token, max_age: @twenty_four_hours)
  end
end
