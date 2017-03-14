defmodule Syndeo.MealQuery do
  alias Syndeo.Repo
  alias Syndeo.Meal

  def find_meal do
    wed = Meal.find_wed
    meal =
      Meal
      |> Repo.get_by(date: wed)
    if meal do
      meal
    else
      %Syndeo.Meal{
        description: "No Meal",
      }
    end
  end
end
