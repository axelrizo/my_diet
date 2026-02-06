defmodule MyDietWeb.Resolvers.Foods do
  alias MyDiet.Foods.Food
  alias MyDiet.Repo
  alias MyDiet.Foods.FoodCategories.FoodCategory

  def list_foods(_parent, _args, _resolution) do
    {:ok, Repo.all(Food)}
  end

  def list_food_categories(_parent, _args, _resolution) do
    {:ok, Repo.all(FoodCategory)}
  end
end
