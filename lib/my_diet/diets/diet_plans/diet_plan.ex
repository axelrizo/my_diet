defmodule MyDiet.Diets.DietPlans.DietPlan do
  use Ecto.Schema

  schema "diets_meals" do
    field :quantity, :decimal

    belongs_to :diet, MyDiet.Diets.Diet
    belongs_to :meal, MyDiet.Meals.Meal

    timestamps()
  end
end
