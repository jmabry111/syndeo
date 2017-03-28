defmodule Syndeo.SessionController do
  use Syndeo.Web, :controller
  import Doorman.Login.Session

  def new(conn, _params) do
    conn
    |> render(:new)
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    if user = Doorman.authenticate(email, password) do
      conn
      |> login(user)
      |> put_flash(:notice, gettext("Successfully logged in"))
      |> redirect(to: redirect_path(conn))
    else
      prevent_brute_force_attacks

      conn
      |> put_flash(:error, gettext("Invalid email or password"))
      |> render(:new)
    end
  end

  def delete(conn, _) do
    conn
    |> logout
    |> redirect(to: session_path(conn, :new))
  end

  defp prevent_brute_force_attacks do
    :timer.sleep(1000)
  end

  defp redirect_path(conn) do
    get_session(conn, :redirect_path) || "/admin/attendees"
  end
end
