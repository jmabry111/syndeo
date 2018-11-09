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

  def weekly_email(weekly_info, attendee, meal) do
    base_email()
    |> to(attendee.email)
    |> subject("Thanks for connecting!")
    |> put_layout({Syndeo.LayoutView, :email})
    |> render(:weekly_info, weekly_info: weekly_info, attendee: attendee, meal: meal)
  end

  def base_email do
    new_email()
    |> from("noreply@stonemcc.com")
  end
end
