defmodule MyDietWeb.Resolvers.Foods do
  @moduledoc """
  Resolvers for foods-related queries and mutations in the GraphQL schema.
  """

  alias MyDiet.Foods.Food
  alias MyDiet.Foods.FoodCategories.FoodCategory
  alias MyDiet.Repo

  @doc """
  Resolver for fetching all foods.
  """
  @spec list_foods(term(), term(), term()) :: {:ok, [Food.t()]}
  def list_foods(_parent, _args, _resolution) do
    {:ok, Repo.all(Food)}
  end

  @doc """
  Resolver for fetching all food categories.
  """
  @spec list_food_categories(term(), term(), term()) :: {:ok, [FoodCategory.t()]}
  def list_food_categories(_parent, _args, _resolution) do
    {:ok, Repo.all(FoodCategory)}
  end
end
