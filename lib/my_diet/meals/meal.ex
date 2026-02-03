defmodule MyDiet.Meals.Meal do
  @moduledoc """
  Represents a meal in the system.
  """

  use Ecto.Schema

  alias MyDiet.Meals.MealIngredients.MealIngredient
  alias MyDiet.Diets.DietMeals.DietMeal

  @typedoc """
  Represents a meal in the system.

  ## Fields

    - `id` - The unique identifier for the meal.
    - `name` - The name of the meal.
    - `meal_ingredients` - List of associated `MealIngredient` structs.
    - `diet_meals` - List of associated `DietMeal` structs.
    - `inserted_at` - Timestamp when the record was created.
    - `updated_at` - Timestamp when the record was last updated.
  """
  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          meal_ingredients: [MealIngredient.t()],
          diet_meals: [DietMeal.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "meals" do
    field :name, :string

    has_many :meal_ingredients, MealIngredient
    has_many :diet_meals, DietMeal

    timestamps()
  end
end
