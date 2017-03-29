defmodule Syndeo.Admin.AttendeeController do
  use Syndeo.Web, :controller
  import Syndeo.AttendeeQuery
  alias Syndeo.Attendee

  def index(conn, _params) do
    attendees = Repo.all(Attendee)
    conn
    |> assign(:attendees, attendees)
    |> render(:index)
  end

  def show(conn, %{"id" => id}) do
    attendee = find_attendee!(id)
    conn
    |> assign(:attendee, attendee)
    |> render(:show)
  end

  def edit(conn, %{"id" => id}) do
    attendee = find_attendee!(id)
    changeset = Attendee.changeset(attendee)

    conn
    |> assign(:attendee, attendee)
    |> assign(:changeset, changeset)
    |> render(:edit)
  end

  def update(conn, %{"id" => id, "attendee" => attendee_params}) do
    attendee = find_attendee!(id)
    changeset = Attendee.changeset(attendee, attendee_params)

    case Repo.update(changeset) do
      {:ok, attendee} ->
        conn
        |> put_flash(:info, "Attendee updated successfully.")
        |> redirect(to: attendee_path(conn, :show, attendee))
      {:error, changeset} ->
        conn
        |> assign(:attendee, attendee)
        |> assign(:changeset, changeset)
        |> render(:edit)
    end
  end

  def delete(conn, %{"id" => id}) do
    Attendee
    |> Repo.get!(id)
    |> Repo.delete!

    conn
    |> put_flash(:info, "Attendee deleted successfully.")
    |> redirect(to: admin_attendee_path(conn, :index))
  end
end
