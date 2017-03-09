defmodule Syndeo.WeeklyInfoController do
  use Syndeo.Web, :controller
  alias Syndeo.WeeklyInfo
  alias Syndeo.Attendee
  import Syndeo.AttendeeQuery
  import Syndeo.MealQuery

  def index(conn, %{"attendee_id" => attendee_id}) do
    attendee = find_attendee!(attendee_id)
    meal = find_meal()
    no_wednesday_meal =
      %Syndeo.Meal{
        description: "NO MEAL",
      }
    IO.inspect(meal)
    IO.inspect(no_wednesday_meal)
    changeset = WeeklyInfo.changeset(%WeeklyInfo{})

    if meal.id == 0 do
      conn
      |> render_index(attendee, no_wednesday_meal, changeset)
    else
      conn
      |> render_index(attendee, meal, changeset)
    end
  end

  def create(conn, %{"attendee_id" => attendee_id, "weekly_info" => weekly_info_params}) do
    params = Map.merge(weekly_info_params, %{"attendee_id" => attendee_id})
    meal = find_meal()
    changeset = WeeklyInfo.changeset(%WeeklyInfo{}, params)

    case Repo.insert(changeset) do
      {:ok, _weekly_info} ->
        conn
        |> put_flash(:info, gettext("We've added your info for this week."))
        |> redirect(to: attendee_weekly_info_path(conn, :index, attendee_id))
      {:error, changeset} ->
        attendee = find_attendee!(attendee_id)

        conn
        |> render_index(attendee, meal, changeset)
    end
  end

  def delete(conn, %{"attendee_id" => attendee_id, "id" => weekly_info_id}) do
    WeeklyInfo
    |> where(attendee_id: ^attendee_id, id: ^weekly_info_id)
    |> Repo.one
    |> Repo.delete!

    conn
    |> put_flash(:info, gettext("This week's info has been removed."))
    |> redirect(to: attendee_weekly_info_path(conn, :index, attendee_id))
  end

  defp render_index(conn, %Attendee{}=attendee, meal, changeset) do
    conn
    |> assign(:attendee, attendee)
    |> assign(:weekly_info, attendee.weekly_info)
    |> assign(:meal, meal)
    |> assign(:no_wednesday_meal, is_nil(meal))
    |> assign(:changeset, changeset)
    |> render(:index)
  end
end
