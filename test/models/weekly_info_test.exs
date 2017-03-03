defmodule Syndeo.WeeklyInfoTest do
  use Syndeo.ModelCase
  alias Syndeo.WeeklyInfo

  @valid_attrs %{
    attendee_id: "1",
    attending_meal: true, 
    contact: "some contant", 
    num_adults: 42, 
    num_kids: 42, 
    num_teens: 42, 
    prayers: "some content", 
    week_date: Timex.today
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = WeeklyInfo.changeset(%WeeklyInfo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = WeeklyInfo.changeset(%WeeklyInfo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
