defmodule MyDietWeb.Schema.MealsTypes do
  @moduledoc """
  This module defines the GraphQL types for meals and their related entities.
  """

  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MyDietWeb.Resolvers.Fields
  alias MyDiet.Foods
  alias MyDiet.Meals

  @desc "A meal, which consists of multiple food measures (meal ingredients)"
  object :meal do
    @desc "The unique identifier of the meal"
    field :id, :id

    @desc "The name of the meal (e.g., 'Eggs and Toast', 'Chicken Salad')"
    field :name, non_null(:string)

    @desc "The ingredients that make up this meal, each with a specific food measure and quantity"
    field :meal_ingredients, list_of(:meal_ingredient), resolve: dataloader(Meals)
  end

  @desc "An ingredient within a meal"
  object :meal_ingredient do
    @desc "The unique identifier of the meal ingredient"
    field :id, :id

    @desc "The quantity of the food measure used in this meal ingredient (e.g., 2 for 2 cups)"
    field :quantity, non_null(:float), resolve: Fields.decimal_to_float(:quantity)

    @desc "The meal that this ingredient belongs to"
    field :food_measure, :food_measure, resolve: dataloader(Foods)
  end
end
