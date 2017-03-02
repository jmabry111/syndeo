defmodule ConnectionCard.TokenizedEmail do
  alias ConnectionCard.Attendee
  alias ConnectionCard.AttendeeSession
  alias ConnectionCard.Repo
  import Ecto.Query
  alias ConnectionCard.AttendeeEmail
  alias ConnectionCard.Mailer

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
