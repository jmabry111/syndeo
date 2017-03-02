defmodule ConnectionCard.AttendeeController do
  use ConnectionCard.Web, :controller
  alias ConnectionCard.AttendeeSession
  alias ConnectionCard.Attendee
  alias ConnectionCard.AttendeeEmail
  alias ConnectionCard.TokenizedEmail
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
        |> AttendeeSession.login_attendee(attendee)
        |> put_flash(:info, "Attendee created successfully.")
        |> redirect(to: attendee_weekly_info_path(conn, :index, attendee))
      {:error, changeset} ->
        if email_taken?(changeset) do
          TokenizedEmail.send_tokenized_email(changeset.changes[:email])
          conn
          |> put_flash(:error, gettext("Hey! Looks like you've been here before. :) Please check your email for a link to sign in and fill in your info for this week."))
          |> redirect(to: "/attendees/new")
        else
          conn
          |> assign(:changeset, changeset)
          |> render(:new)
        end
    end
  end

  def show(conn, %{"id" => _id}) do
    attendee = conn.assigns[:current_attendee]
    conn
    |> assign(:weekly_info, attendee.weekly_info)
    |> assign(:attendee, attendee)
    |> render(:show)
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

  defp email_taken?(changeset) do
    {:email, {"has already been taken", []}} in changeset.errors
  end
end
