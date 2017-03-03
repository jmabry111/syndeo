defmodule Syndeo.AttendeeEmail do
  use Bamboo.Phoenix, view: Syndeo.EmailView

  def thank_you_email(attendee) do
    base_email()
    |> to(attendee.email)
    |> subject("Thank you!")
    |> put_layout({Syndeo.LayoutView, :email})
    |> render(:thank_you, attendee: attendee)
  end

  def tokenized_email(attendee, token) do
    base_email()
    |> to(attendee.email)
    |> subject("Fill out another card")
    |> put_layout({Syndeo.LayoutView, :email})
    |> render(:tokenized_link, attendee: attendee, token: token)
  end

  def base_email do
    new_email()
    |> from("noreply@example.com")
  end
end
