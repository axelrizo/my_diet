defmodule MyDietWeb.Schema.FoodsTypes do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MyDiet.Foods
  alias MyDiet.Meals

  object :food do
    field :id, :id
    field :name, non_null(:string)

    field :food_category, :food_category do
      resolve(dataloader(Foods))
    end

    field :food_measures, list_of(:food_measure) do
      resolve(dataloader(Foods))
    end
  end

  object :food_category do
    field :id, :id
    field :name, non_null(:string)

    field :foods, list_of(:food) do
      resolve(dataloader(Foods))
    end
  end

  object :food_measure do
    field :id, :id
    field :portion, non_null(:string)
    field :fats, non_null(:decimal)
    field :carbohydrates, non_null(:decimal)
    field :proteins, non_null(:decimal)

    field :food, :food do
      resolve(dataloader(Foods))
    end

    field :meal_ingredients, list_of(:meal_ingredient) do
      resolve(dataloader(Meals))
    end
  end
end
