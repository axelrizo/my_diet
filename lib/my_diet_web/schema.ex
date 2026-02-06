defmodule MyDietWeb.Schema do
  use Absinthe.Schema

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MyDiet.Foods
  alias MyDiet.Meals
  alias MyDiet.Repo

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Foods, Foods.data())
      |> Dataloader.add_source(Meals, Meals.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  scalar :decimal do
    parse(fn
      %Absinthe.Blueprint.Input.String{value: value} ->
        case Decimal.parse(value) do
          {decimal, ""} -> {:ok, decimal}
          {_, _} -> :error
          :error -> :error
        end

      %Absinthe.Blueprint.Input.Float{value: value} ->
        {:ok, Decimal.from_float(value)}

      %Absinthe.Blueprint.Input.Integer{value: value} ->
        {:ok, Decimal.new(value)}

      _ ->
        :error
    end)

    serialize(fn decimal -> Decimal.to_string(decimal) end)
  end

  query do
    field :foods, list_of(:food) do
      resolve(fn _parent, _args, _resolution ->
        {:ok, Repo.all(Foods.Food)}
      end)
    end

    field :all_food_categories, list_of(:food_category) do
      resolve(fn _parent, _args, _resolution ->
        {:ok, Repo.all(Foods.FoodCategories.FoodCategory)}
      end)
    end

    field :all_meals, list_of(:meal) do
      resolve(fn _parent, _args, _resolution ->
        {:ok, Repo.all(MyDiet.Meals.Meal)}
      end)
    end
  end

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
