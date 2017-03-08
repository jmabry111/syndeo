defmodule Syndeo.MealQuery do
  alias Syndeo.Repo
  alias Syndeo.Meal

  def find_meal do
    wed = Meal.find_wed
    Meal
    |> Repo.get_by!(date: wed)
  end
end
