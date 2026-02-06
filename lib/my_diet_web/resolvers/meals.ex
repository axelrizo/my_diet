defmodule MyDietWeb.Resolvers.Meals do
  alias MyDiet.Meals.Meal
  alias MyDiet.Repo

  def list_meals(_parent, _args, _resolution) do
    {:ok, Repo.all(Meal)}
  end
end
