defmodule MyDiet.Diets.DietMeals.DietMeal do
  @moduledoc """
  Meals that compose a diet along with their quantities.
  """

  use Ecto.Schema

  alias MyDiet.Diets.Diet
  alias MyDiet.Meals.Meal

  @typedoc """
  Represents a meal that is part of a diet along with its quantity.

  ## Fields
    - `id`: The unique identifier for the diet meal.
    - `quantity`: The quantity of the meal in the diet.
    - `diet_id`: The ID of the associated diet.
    - `diet`: The associated `Diet` struct.
    - `meal_id`: The ID of the associated meal.
    - `meal`: The associated `Meal` struct.
    - `inserted_at`: The timestamp when the diet meal was created.
    - `updated_at`: The timestamp when the diet meal was last updated.
  """
  @type t :: %__MODULE__{
          id: integer(),
          quantity: Decimal.t(),
          diet_id: integer(),
          diet: Diet.t(),
          meal_id: integer(),
          meal: Meal.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "diets_meals" do
    field :quantity, :decimal

    belongs_to :diet, Diet
    belongs_to :meal, Meal

    timestamps()
  end
end
