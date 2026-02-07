defmodule MyDietWeb.Resolvers.Meals do
  @moduledoc """
  This module defines the resolvers for meals-related queries and mutations in the GraphQL schema.
  """

  alias MyDiet.Meals.Meal
  alias MyDiet.Repo

  @doc """
  Resolver for fetching all meals.
  """
  @spec list_meals(term(), term(), term()) :: {:ok, [Meal.t()]}
  def list_meals(_parent, _args, _resolution) do
    {:ok, Repo.all(Meal)}
  end
end
