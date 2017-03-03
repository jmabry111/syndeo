defmodule Syndeo.MealControllerTest do
  use Syndeo.ConnCase

  alias Syndeo.Meal
  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, description: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, meal_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing meals"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, meal_path(conn, :new)
    assert html_response(conn, 200) =~ "Meal Info"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, meal_path(conn, :create), meal: @valid_attrs
    assert redirected_to(conn) == meal_path(conn, :index)
    assert Repo.get_by(Meal, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, meal_path(conn, :create), meal: @invalid_attrs
    assert html_response(conn, 200) =~ "Meal Info"
  end

  test "shows chosen resource", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = get conn, meal_path(conn, :show, meal)
    assert html_response(conn, 200) =~ "Show meal"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, meal_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = get conn, meal_path(conn, :edit, meal)
    assert html_response(conn, 200) =~ "Edit meal"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = put conn, meal_path(conn, :update, meal), meal: @valid_attrs
    assert redirected_to(conn) == meal_path(conn, :show, meal)
    assert Repo.get_by(Meal, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = put conn, meal_path(conn, :update, meal), meal: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit meal"
  end

  test "deletes chosen resource", %{conn: conn} do
    meal = Repo.insert! %Meal{}
    conn = delete conn, meal_path(conn, :delete, meal)
    assert redirected_to(conn) == meal_path(conn, :index)
    refute Repo.get(Meal, meal.id)
  end
end
