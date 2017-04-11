defmodule Syndeo.Admin.AttendeeControllerTest do
  use Syndeo.ConnCase

  alias Syndeo.Attendee

  setup _ do
    {
      :ok,
      conn: Phoenix.ConnTest.build_conn(),
      id: build(:user) |> save |> Map.get(:id),
    }
  end

  test "lists all entries on index", %{conn: conn, id: id} do
    conn = get conn, admin_attendee_path(conn, :index, as: id)
    assert html_response(conn, 200) =~ "Attendees"
  end

  test "shows chosen resource", %{conn: conn, id: id} do
    attendee = Repo.insert! %Attendee{name: "name", city: "city", state: "st", email: "email@example.com", membership_status: "member", age_range: "adult"}
    conn = get conn, admin_attendee_path(conn, :show, attendee, as: id)
    assert html_response(conn, 200) =~ "Information for #{attendee.name}"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, id: id} do
    assert_error_sent 404, fn ->
      get conn, admin_attendee_path(conn, :show, "00000000-0000-0000-0000-000000000000", as: id)
    end
  end

  test "deletes chosen resource", %{conn: conn, id: id} do
    attendee = Repo.insert! %Attendee{name: "name", city: "city", state: "st", email: "email@example.com", membership_status: "member", age_range: "adult"}
    conn = delete conn, admin_attendee_path(conn, :delete, attendee, as: id)
    assert redirected_to(conn) == admin_attendee_path(conn, :index)
    refute Repo.get(Attendee, attendee.id)
  end
end
