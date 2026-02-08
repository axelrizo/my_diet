defmodule MyDiet.Foods.FoodCategories do
  @moduledoc """
  Context module for managing food categories queries, operations, and some business logic.
  """

  alias Ecto.Changeset
  alias MyDiet.Foods.FoodCategories.FoodCategory
  alias MyDiet.Repo

  @doc """
  Creates a new food category with the given attributes.
  """
  @spec create(map()) :: {:ok, FoodCategory.t()} | {:error, Changeset.t()}
  def create(attrs) do
    %FoodCategory{}
    |> FoodCategory.changeset(attrs)
    |> Repo.insert()
  end
end
