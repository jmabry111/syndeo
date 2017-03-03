defmodule Syndeo.AttendeeControllerTest do
  use Syndeo.ConnCase

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    path = attendee_path(conn, :create)

    conn = post conn, path, attendee: %{"name" => ""}

    assert html_response(conn, 200) =~ "First time connecting online?"
  end
end
