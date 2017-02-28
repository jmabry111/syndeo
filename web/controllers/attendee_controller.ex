defmodule ConnectionCard.AttendeeController do
  use ConnectionCard.Web, :controller
  alias ConnectionCard.Attendee
  alias ConnectionCard.AttendeeEmail
  alias ConnectionCard.Mailer

  def index(conn, _params) do
    attendees = Repo.all(Attendee)
    render(conn, "index.html", attendees: attendees)
  end

  def new(conn, _params) do
    changeset = Attendee.changeset(%Attendee{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"attendee" => attendee_params}) do
    changeset = Attendee.changeset(%Attendee{}, attendee_params)

    case Repo.insert(changeset) do
      {:ok, attendee} ->
        attendee
        |> AttendeeEmail.thank_you_email
        |> Mailer.deliver_later

        conn
        |> put_flash(:info, "Attendee created successfully.")
        |> redirect(to: attendee_weekly_info_path(conn, :index, attendee))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    attendee = Repo.get!(Attendee, id)
    render(conn, "show.html", attendee: attendee)
  end

  def edit(conn, %{"id" => id}) do
    attendee = Repo.get!(Attendee, id)
    changeset = Attendee.changeset(attendee)
    render(conn, "edit.html", attendee: attendee, changeset: changeset)
  end

  def update(conn, %{"id" => id, "attendee" => attendee_params}) do
    attendee = Repo.get!(Attendee, id)
    changeset = Attendee.changeset(attendee, attendee_params)

    case Repo.update(changeset) do
      {:ok, attendee} ->
        conn
        |> put_flash(:info, "Attendee updated successfully.")
        |> redirect(to: attendee_path(conn, :show, attendee))
      {:error, changeset} ->
        render(conn, "edit.html", attendee: attendee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attendee = Repo.get!(Attendee, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(attendee)

    conn
    |> put_flash(:info, "Attendee deleted successfully.")
    |> redirect(to: attendee_path(conn, :index))
  end
end
