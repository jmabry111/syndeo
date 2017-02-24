defmodule ConnectionCard.WeeklyInfoControllerTest do
  use ConnectionCard.ConnCase

  alias ConnectionCard.WeeklyInfo
  @valid_attrs %{attending_meal: true, contact: "some content", num_kids: 42, num_teens: 42, prayers: "some content", week_date: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, weekly_info_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing weeklyinfo"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, weekly_info_path(conn, :new)
    assert html_response(conn, 200) =~ "New weekly info"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, weekly_info_path(conn, :create), weekly_info: @valid_attrs
    assert redirected_to(conn) == weekly_info_path(conn, :index)
    assert Repo.get_by(WeeklyInfo, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, weekly_info_path(conn, :create), weekly_info: @invalid_attrs
    assert html_response(conn, 200) =~ "New weekly info"
  end

  test "shows chosen resource", %{conn: conn} do
    weekly_info = Repo.insert! %WeeklyInfo{}
    conn = get conn, weekly_info_path(conn, :show, weekly_info)
    assert html_response(conn, 200) =~ "Show weekly info"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, weekly_info_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    weekly_info = Repo.insert! %WeeklyInfo{}
    conn = get conn, weekly_info_path(conn, :edit, weekly_info)
    assert html_response(conn, 200) =~ "Edit weekly info"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    weekly_info = Repo.insert! %WeeklyInfo{}
    conn = put conn, weekly_info_path(conn, :update, weekly_info), weekly_info: @valid_attrs
    assert redirected_to(conn) == weekly_info_path(conn, :show, weekly_info)
    assert Repo.get_by(WeeklyInfo, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    weekly_info = Repo.insert! %WeeklyInfo{}
    conn = put conn, weekly_info_path(conn, :update, weekly_info), weekly_info: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit weekly info"
  end

  test "deletes chosen resource", %{conn: conn} do
    weekly_info = Repo.insert! %WeeklyInfo{}
    conn = delete conn, weekly_info_path(conn, :delete, weekly_info)
    assert redirected_to(conn) == weekly_info_path(conn, :index)
    refute Repo.get(WeeklyInfo, weekly_info.id)
  end
end
