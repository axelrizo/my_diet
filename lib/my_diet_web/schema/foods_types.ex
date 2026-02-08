defmodule MyDietWeb.Schema.FoodsTypes do
  @moduledoc """
  This module defines the GraphQL types for foods and their related entities.
  """

  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.Payload
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias MyDiet.Foods
  alias MyDiet.Meals

  @desc "A food, which belongs to a category and has multiple measures"
  object :food do
    @desc "The unique identifier of the food"
    field :id, :id

    @desc "The name of the food"
    field :name, non_null(:string)

    @desc "The category this food belongs to"
    field :food_category, :food_category, resolve: dataloader(Foods)

    @desc "The different measures for this food, each with its own nutritional information"
    field :food_measures, list_of(:food_measure), resolve: dataloader(Foods)
  end

  @desc "A food's category, which can have multiple foods"
  object :food_category do
    @desc "The unique identifier of the food category"
    field :id, :id

    @desc "The name of the food category (e.g., 'Fruits', 'Vegetables', 'Grains')"
    field :name, non_null(:string)

    @desc "The food items that belong to this category"
    field :foods, list_of(:food), resolve: dataloader(Foods)
  end

  @desc "Payload object for food category mutations"
  payload_object(:food_category_payload, :food_category)

  @desc "A food measure, which specifies the portion size and its nutritional information for a specific food"
  object :food_measure do
    @desc "The unique identifier of the food measure"
    field :id, :id

    @desc "The name of the measure (e.g., 'cup', 'slice', 'piece')"
    field :portion, non_null(:string)

    @desc "Fats in grams for this measure of the food"
    field :fats, non_null(:float), resolve: decimal_to_float(:fats)

    @desc "Carbohydrates in grams for this measure of the food"
    field :carbohydrates, non_null(:float), resolve: decimal_to_float(:carbohydrates)

    @desc "Proteins in grams for this measure of the food"
    field :proteins, non_null(:float), resolve: decimal_to_float(:proteins)

    @desc "The food that this measure belongs to"
    field :food, :food, resolve: dataloader(Foods)

    @desc "The meal ingredients that use this food measure"
    field :meal_ingredients, list_of(:meal_ingredient), resolve: dataloader(Meals)
  end

  defp decimal_to_float(field_name) do
    fn parent, _args, _resolution ->
      {:ok, Decimal.to_float(Map.get(parent, field_name))}
    end
  end
end
