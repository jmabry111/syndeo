defmodule Syndeo.RequireAdmin do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, _default) do
    if conn.assigns[:current_user] == nil do
      conn
      |> put_session(:redirect_path, conn.request_path)
      |> put_flash(:error, "You must log in to see this page")
      |> redirect(to: "/session/new")
      |> halt
    else
      conn
    end
  end
end
