defmodule Syndeo.Feature.AttendeeTest do
  use Syndeo.FeatureCase
  use Bamboo.Test, shared: :true
  alias Syndeo.Attendee

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

    email = Syndeo.AttendeeEmail.thank_you_email(attendee)
    email |> Syndeo.Mailer.deliver_now
    assert_delivered_email Syndeo.AttendeeEmail.thank_you_email(attendee)
  end

  test "attendee gets email if registering again" do
    attendee = insert(:attendee)
    token = Phoenix.Token.sign(Syndeo.Endpoint, "attendee", attendee.email)

    navigate_to "/"
    fill_in "attendee", :name, with: attendee.name
    fill_in "attendee", :email, with: attendee.email
    fill_in "attendee", :city, with: attendee.city
    fill_in "attendee", :state, with: attendee.state
    select "10:30", from: "service"
    select "Adult", from: "age_range"
    select "Member", from: "membership_status"
    submit()

    email = Syndeo.AttendeeEmail.tokenized_email(attendee, token)
    email |> Syndeo.Mailer.deliver_now

    assert visible_page_text() =~ "Hey! Looks like you've been here before."
    assert_delivered_email email
  end

  test "attendee can use alternate form to recieve email" do
    attendee = insert(:attendee)
    token = Phoenix.Token.sign(Syndeo.Endpoint, "attendee", attendee.email)

    navigate_to "/"
    fill_in "attendee", :email, with: attendee.email
    click_on "Send me a link!"

    email = Syndeo.AttendeeEmail.tokenized_email(attendee, token)
    email |> Syndeo.Mailer.deliver_now

    assert visible_page_text() =~ "Email sent!"
    assert_delivered_email email
  end

  test "attendee can sign in with link" do
    attendee = insert(:attendee)
    token = Phoenix.Token.sign(Syndeo.Endpoint, "attendee", attendee.id)

    navigate_to "/"
    fill_in_with_id "return-attendee", with: attendee.email
    click_on "Send me a link!"

    email = Syndeo.AttendeeEmail.tokenized_email(attendee, token)
    email |> Syndeo.Mailer.deliver_now

    assert visible_page_text() =~ "Email sent!"
    assert_delivered_email email

    navigate_to "/attendees/#{attendee.id}?token=#{token}"
    assert visible_page_text() =~ "Hello, #{attendee.name}"
  end
end
