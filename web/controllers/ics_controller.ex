defmodule Syndeo.IcsController do
  use Syndeo.Web, :controller
  alias Syndeo.IcsCreator
  import Syndeo.MealQuery

  def show(conn, _params) do
    meal = find_meal()
    ics = IcsCreator.create_ics(meal.date, meal.description)
    conn
    |> send_ics(ics)
  end

  defp send_ics(conn, contents) do
    filename = "SMCC_Meal"
    conn
    |> put_resp_content_type("text/ics")
    |> put_resp_header("content-disposition", "attachment; filename=\"#{filename}.ics\"")
    |> send_resp(200, contents)
  end
end
