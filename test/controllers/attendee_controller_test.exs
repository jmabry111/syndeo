defmodule ConnectionCard.AttendeeControllerTest do
  use ConnectionCard.ConnCase

  alias ConnectionCard.Attendee
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, attendee_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing attendees"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, attendee_path(conn, :new)
    assert html_response(conn, 200) =~ "New attendee"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, attendee_path(conn, :create), attendee: @valid_attrs
    assert redirected_to(conn) == attendee_path(conn, :index)
    assert Repo.get_by(Attendee, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, attendee_path(conn, :create), attendee: @invalid_attrs
    assert html_response(conn, 200) =~ "New attendee"
  end

  test "shows chosen resource", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = get conn, attendee_path(conn, :show, attendee)
    assert html_response(conn, 200) =~ "Show attendee"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, attendee_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = get conn, attendee_path(conn, :edit, attendee)
    assert html_response(conn, 200) =~ "Edit attendee"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = put conn, attendee_path(conn, :update, attendee), attendee: @valid_attrs
    assert redirected_to(conn) == attendee_path(conn, :show, attendee)
    assert Repo.get_by(Attendee, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = put conn, attendee_path(conn, :update, attendee), attendee: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit attendee"
  end

  test "deletes chosen resource", %{conn: conn} do
    attendee = Repo.insert! %Attendee{}
    conn = delete conn, attendee_path(conn, :delete, attendee)
    assert redirected_to(conn) == attendee_path(conn, :index)
    refute Repo.get(Attendee, attendee.id)
  end
end
