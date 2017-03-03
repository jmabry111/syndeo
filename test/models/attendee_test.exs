defmodule Syndeo.AttendeeTest do
  use Syndeo.ModelCase
  use Hound.Helpers
  alias Syndeo.Attendee

  @valid_attrs %{
    age_range: "some content", 
    city: "some content", 
    email: "some@content.com", 
    membership_status: "some content", 
    name: "some content", 
    phone: "some content", 
    service: "some content", 
    sms: true, 
    state: "some content", 
    street: "some content", 
    zip: "some content"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Attendee.changeset(%Attendee{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Attendee.changeset(%Attendee{}, @invalid_attrs)
    refute changeset.valid?
  end
end
