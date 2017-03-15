defmodule Syndeo.Feature.WeeklyInfoTest do
  use Syndeo.FeatureCase
  use Bamboo.Test, shared: :true
  alias Syndeo.Attendee
  alias Syndeo.WeeklyInfo

  test "create an attendee and weekly card" do
    navigate_to "/"
    fill_in "attendee", :name, with: "John Paul"
    fill_in "attendee", :email, with: "jp@example.com"
    fill_in "attendee", :phone, with: "2342345555"
    fill_in "attendee", :street, with: "3 Holy St."
    fill_in "attendee", :city, with: "Rome"
    fill_in "attendee", :state, with: "GA"
    fill_in "attendee", :zip, with: "99999"
    select "Adult", from: "age_range"
    select "Member", from: "membership_status"
    submit()

    select "9:00", from: "service"
    select "Church membership", from: "contact"
    fill_in "weekly_info", :prayers, with: "Pray for our leaders"
    submit()

    assert visible_page_text() =~ "We've added your info for this week."
  end

  test "create an attendee and weekly card with meal info" do
    meal = insert(:meal)

    navigate_to "/"
    fill_in "attendee", :name, with: "John Paul"
    fill_in "attendee", :email, with: "jp@example.com"
    fill_in "attendee", :phone, with: "2342345555"
    fill_in "attendee", :street, with: "3 Holy St."
    fill_in "attendee", :city, with: "Rome"
    fill_in "attendee", :state, with: "GA"
    fill_in "attendee", :zip, with: "99999"
    select "Adult", from: "age_range"
    select "Member", from: "membership_status"
    submit()

    select "9:00", from: "service"
    select "Church membership", from: "contact"
    fill_in "weekly_info", :prayers, with: "Pray for our leaders"
    take_screenshot("shot.png")
    select "Yes", from: "attending_meal"
    fill_in "weekly_info", :num_teens, with: 1
    fill_in "weekly_info", :num_adults, with: 2
    submit()

    attendee = Attendee |> Repo.one
    weekly = WeeklyInfo |> Repo.one

    email = Syndeo.AttendeeEmail.weekly_email(weekly, attendee, meal)
    email |> Syndeo.Mailer.deliver_now
    assert_delivered_email Syndeo.AttendeeEmail.weekly_email(weekly, attendee, meal)

    assert visible_page_text() =~ "We've added your info for this week."
  end
end
