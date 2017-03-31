defmodule Syndeo.Admin.MealControllerTest do
  use Syndeo.ConnCase

  alias Syndeo.Meal

  setup _ do
    {
      :ok,
      conn: Phoenix.ConnTest.build_conn(),
      id: build(:user) |> save |> Map.get(:id),
    }
  end

  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, description: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn, id: id} do
    conn = get conn, admin_meal_path(conn, :index, as: id)
    assert html_response(conn, 200) =~ "Listing meals"
  end

  test "renders form for new resources", %{conn: conn, id: id} do
    conn = get conn, admin_meal_path(conn, :new, as: id)
    assert html_response(conn, 200) =~ "Meal Info"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, id: id} do
    conn = post conn, admin_meal_path(conn, :create, as: id), meal: @valid_attrs
    assert redirected_to(conn) == admin_meal_path(conn, :index)
    assert Repo.get_by(Meal, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, id: id} do
    conn = post conn, admin_meal_path(conn, :create, as: id), meal: @invalid_attrs
    assert html_response(conn, 200) =~ "Meal Info"
  end

  test "shows chosen resource", %{conn: conn, id: id} do
    meal = Repo.insert! %Meal{}
    conn = get conn, admin_meal_path(conn, :show, meal, as: id)
    assert html_response(conn, 200) =~ "Show meal"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, id: id} do
    assert_error_sent 404, fn ->
      get conn, admin_meal_path(conn, :show, -1, as: id)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, id: id} do
    meal = Repo.insert! %Meal{}
    conn = get conn, admin_meal_path(conn, :edit, meal, as: id)
    assert html_response(conn, 200) =~ "Edit meal"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, id: id} do
    meal = Repo.insert! %Meal{}
    conn = put conn, admin_meal_path(conn, :update, meal, as: id), meal: @valid_attrs
    assert redirected_to(conn) == admin_meal_path(conn, :show, meal)
    assert Repo.get_by(Meal, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, id: id} do
    meal = Repo.insert! %Meal{}
    conn = put conn, admin_meal_path(conn, :update, meal, as: id), meal: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit meal"
  end

  test "deletes chosen resource", %{conn: conn, id: id} do
    meal = Repo.insert! %Meal{}
    conn = delete conn, admin_meal_path(conn, :delete, meal, as: id)
    assert redirected_to(conn) == admin_meal_path(conn, :index)
    refute Repo.get(Meal, meal.id)
  end
end
