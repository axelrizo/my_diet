defmodule MyDietWeb.Schema.MealsTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MyDiet.Meals

  object :meal do
    field :id, :id
    field :name, non_null(:string)

    field :meal_ingredients, list_of(:meal_ingredient) do
      resolve(dataloader(Meals))
    end
  end

  object :meal_ingredient do
    field :id, :id
    field :quantity, non_null(:decimal)

    field :food_measure, :food_measure do
      resolve(dataloader(Meals))
    end
  end
end
