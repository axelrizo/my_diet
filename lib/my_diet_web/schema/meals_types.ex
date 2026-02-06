defmodule MyDietWeb.Schema.MealsTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MyDiet.Meals

  @desc "A meal, which consists of multiple ingredients"
  object :meal do
    field :id, :id
    field :name, non_null(:string)

    field :meal_ingredients, list_of(:meal_ingredient), resolve: dataloader(Meals)
  end

  @desc "An ingredient within a meal"
  object :meal_ingredient do
    field :id, :id
    field :quantity, non_null(:decimal)

    field :food_measure, :food_measure, resolve: dataloader(Meals)
  end
end
