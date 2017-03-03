defmodule Syndeo.TokenizedEmail do
  alias Syndeo.Attendee
  alias Syndeo.AttendeeSession
  alias Syndeo.Repo
  import Ecto.Query
  alias Syndeo.AttendeeEmail
  alias Syndeo.Mailer

  def send_tokenized_email(email) do
    attendee = Attendee |> where(email: ^email) |> Repo.one

    if attendee do
      token = AttendeeSession.generate_token(attendee)

      attendee
      |> AttendeeEmail.tokenized_email(token)
      |> Mailer.deliver_later
    end
  end
end
