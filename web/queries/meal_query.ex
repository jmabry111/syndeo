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
        date: ~D[1900-01-01],
        description: "none",
        id: 0,
      }
    end
  end
end
