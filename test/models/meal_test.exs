defmodule Syndeo.MealTest do
  use Syndeo.ModelCase

  alias Syndeo.Meal

  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Meal.changeset(%Meal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Meal.changeset(%Meal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
