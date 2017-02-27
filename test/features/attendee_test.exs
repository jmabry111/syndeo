defmodule ConnectionCard.Feature.AttendeeTest do
  use ConnectionCard.FeatureCase
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
end
