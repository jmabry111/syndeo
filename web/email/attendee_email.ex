defmodule ConnectionCard.AttendeeEmail do
  use Bamboo.Phoenix, view: ConnectionCard.EmailView

  def thank_you_email(attendee) do
    base_email()
    |> to(attendee.email)
    |> subject("Thank you!")
    |> put_layout({ConnectionCard.LayoutView, :email})
    |> render(:thank_you, attendee: attendee)
  end

  def base_email do
    new_email()
    |> from("noreply@example.com")
  end
end
