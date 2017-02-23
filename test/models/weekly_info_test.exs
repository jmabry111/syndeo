defmodule ConnectionCard.WeeklyInfoTest do
  use ConnectionCard.ModelCase

  alias ConnectionCard.WeeklyInfo

  @valid_attrs %{attending_meal: true, contact: true, num_adults: 42, num_kids: 42, num_teens: 42, prayers: "some content", week_date: %{day: 17, month: 4, year: 2010}}
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
