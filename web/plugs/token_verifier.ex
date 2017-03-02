defmodule ConnectionCard.TokenVerifier do
  import Phoenix.Controller
  alias ConnectionCard.AttendeeSession

  def init(default), do: default

  def call(%{query_params: %{"token" => token}} = conn, _default) do
    case AttendeeSession.verify_token(token) do
      {:ok, attendee_id} ->
        conn
        |> AttendeeSession.login_attendee(attendee_id)
      _ ->
        conn
        |> put_flash(:error, "We're very sorry but we could not locate your token")
        |> redirect(to: "/")
        |> Plug.Conn.halt
    end
  end

  def call(conn, _), do: conn
end
