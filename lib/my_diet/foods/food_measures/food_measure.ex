defmodule MyDiet.Foods.FoodMeasures.FoodMeasure do
  @moduledoc """
  Represents the nutritional measures for a food item.
  """

  use Ecto.Schema

  alias MyDiet.Foods.Food

  @typedoc """
  Represents the nutritional measures for a food item.
  ## Fields

    - `id`: The unique identifier for the food measure.
    - `portion`: The portion size description (e.g., "100g", "1 cup").
    - `carbohydrates`: The amount of carbohydrates in the portion.
    - `fats`: The amount of fats in the portion.
    - `proteins`: The amount of proteins in the portion.
    - `food_id`: The identifier of the associated food item.
    - `inserted_at`: The timestamp when the food measure was created.
    - `updated_at`: The timestamp when the food measure was last updated.
  """
  @type t :: %__MODULE__{
          id: integer(),
          portion: String.t(),
          carbohydrates: Decimal.t(),
          fats: Decimal.t(),
          proteins: Decimal.t(),
          food_id: integer(),
          food: Food.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "food_measures" do
    field :portion, :string
    field :carbohydrates, :decimal
    field :fats, :decimal
    field :proteins, :decimal

    belongs_to :food, MyDiet.Foods.Food

    timestamps()
  end
end
