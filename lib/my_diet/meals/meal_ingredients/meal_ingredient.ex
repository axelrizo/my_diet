defmodule MyDiet.Meals.MealIngredients.MealIngredient do
  @moduledoc """
  Ingredients used in meals, linking food measures to meals with specified quantities.
  """

  use Ecto.Schema

  alias MyDiet.Meals.Meal
  alias MyDiet.Foods.FoodMeasures.FoodMeasure

  @typedoc """
  Ingredient in a meal linking a food measure with a specified quantity.

  ## Fields

    - `id` - The unique identifier for the meals_food_measures record.
    - `quantity` - The quantity of the food measure in the meal.
    - `meal_id` - The ID of the associated meal.
    - `meal` - The associated `Meal` struct.
    - `food_measure_id` - The ID of the associated food measure.
    - `food_measure` - The associated `FoodMeasure` struct.
    - `inserted_at` - Timestamp when the record was created.
    - `updated_at` - Timestamp when the record was last updated.
  """
  @type t :: %__MODULE__{
          id: integer(),
          quantity: Decimal.t(),
          meal_id: integer(),
          meal: Meal.t() | nil,
          food_measure_id: integer(),
          food_measure: FoodMeasure.t() | nil,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "meal_ingredients" do
    field :quantity, :decimal

    belongs_to :meal, Meal
    belongs_to :food_measure, FoodMeasure

    timestamps()
  end
end
