defmodule ConnectionCard.RequireAttendee do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, _default) do
    if conn.assigns[:current_attendee] == nil do
      conn
      |> put_session(:redirect_path, conn.request_path)
      |> put_flash(:error, "You must be signed in as a attendee to visit this page")
      |> redirect(to: "/attendees/new")
      |> halt
    else
      conn
    end
  end
end
