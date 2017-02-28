defmodule ConnectionCard.Feature.AttendeeTest do
  use ConnectionCard.FeatureCase
  use Bamboo.Test, shared: :true
  alias ConnectionCard.Attendee

  test "create an attendee" do
    navigate_to "/attendees/new"
    fill_in "attendee", :name, with: "John Paul"
    fill_in "attendee", :email, with: "jp@example.com"
    fill_in "attendee", :phone, with: "2342345555"
    fill_in "attendee", :street, with: "3 Holy St."
    fill_in "attendee", :city, with: "Rome"
    fill_in "attendee", :state, with: "GA"
    fill_in "attendee", :zip, with: "99999"
    select "10:30", from: "service"
    select "Adult", from: "age_range"
    select "Member", from: "membership_status"
    submit()

    attendee = Attendee |> Repo.one
    assert visible_page_text() =~ "Attendee created successfully"
    assert attendee.name == "John Paul"
  end

  test "attendee gets an email after submitting" do
    navigate_to "/attendees/new"
    fill_in "attendee", :name, with: "John Paul II"
    fill_in "attendee", :email, with: "jp2@example.com"
    fill_in "attendee", :phone, with: "2342345555"
    fill_in "attendee", :street, with: "30 Holy St."
    fill_in "attendee", :city, with: "Rome"
    fill_in "attendee", :state, with: "GA"
    fill_in "attendee", :zip, with: "99999"
    select "10:30", from: "service"
    select "Adult", from: "age_range"
    select "Member", from: "membership_status"
    submit()

    attendee = Attendee |> Repo.one

    email = ConnectionCard.AttendeeEmail.thank_you_email(attendee)
    email |> ConnectionCard.Mailer.deliver_now
    assert_delivered_email ConnectionCard.AttendeeEmail.thank_you_email(attendee)
  end
end
