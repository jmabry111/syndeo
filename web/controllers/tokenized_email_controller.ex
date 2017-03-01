defmodule ConnectionCard.TokenizedEmailController do
  use ConnectionCard.Web, :controller
  alias ConnectionCard.TokenizedEmail

  def create(conn, %{"attendee" => %{"email" => email}}) do
    TokenizedEmail.send_tokenized_email(email)

    conn
    |> put_flash(:info, "Email sent!")
    |> redirect(to: "/attendees/new")
  end
end
