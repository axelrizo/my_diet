defmodule MyDiet.Meals.MealsFoodMeasures.MealsFoodMeasure do
  use Ecto.Schema

  schema "meals_food_measures" do
    field :quantity, :decimal

    belongs_to :meal, MyDiet.Meals.Meal
    belongs_to :food_measure, MyDiet.Foods.FoodMeasures.FoodMeasure

    timestamps()
  end
end
