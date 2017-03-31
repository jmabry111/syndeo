defmodule Syndeo.Admin.WeeklyInfoController do
  use Syndeo.Web, :controller
  import Syndeo.AttendeeQuery

  def index(conn, _params) do
    attendees = find_attendees_with_current_week_info()

    conn
    |> assign(:attendees, attendees)
    |> render(:index)
  end
end
