defmodule Syndeo.TokenizedEmailController do
  use Syndeo.Web, :controller
  alias Syndeo.TokenizedEmail

  def create(conn, %{"attendee" => %{"email" => email}}) do
    TokenizedEmail.send_tokenized_email(email)

    conn
    |> put_flash(:info, "Email sent!")
    |> redirect(to: "/attendees/new")
  end
end
