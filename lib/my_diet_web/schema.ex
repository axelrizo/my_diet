defmodule MyDietWeb.Schema do
  @moduledoc """
  This module defines the GraphQL schema.
  """

  use Absinthe.Schema

  import_types(MyDietWeb.Schema.ScalarTypes)
  import_types(MyDietWeb.Schema.FoodsTypes)
  import_types(MyDietWeb.Schema.MealsTypes)

  alias MyDietWeb.Resolvers.Foods
  alias MyDietWeb.Resolvers.Meals

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(MyDiet.Foods, MyDiet.Foods.data())
      |> Dataloader.add_source(MyDiet.Meals, MyDiet.Meals.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "Get all foods"
    field :foods, list_of(:food), resolve: &Foods.list_foods/3

    @desc "Get all food categories"
    field :food_categories, list_of(:food_category), resolve: &Foods.list_food_categories/3

    @desc "Get all meals"
    field :meals, list_of(:meal), resolve: &Meals.list_meals/3
  end

  import AbsintheErrorPayload.Payload
  import_types(AbsintheErrorPayload.ValidationMessageTypes)

  payload_object(:food_category_payload, :food_category)

  mutation do
    @desc "Create a new food category"
    field :create_food_category, type: :food_category_payload do
      @desc "Name of the food category, e.g., 'Fruits', 'Vegetables', Must be unique."
      arg(:name, non_null(:string))

      resolve(&Foods.create_food_category/3)
      middleware(&build_payload/2)
    end
  end
end
