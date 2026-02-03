defmodule MyDiet.Foods.Food do
  @moduledoc """
  Represents a food item.
  """

  use Ecto.Schema

  alias MyDiet.Categories.Category
  alias MyDiet.Foods.FoodMeasures.FoodMeasure

  @typedoc """
  Represents a food item.

  ## Fields

    - `id`: The unique identifier for the food item.
    - `name`: The name of the food item.
    - `category`: The category to which the food item belongs.
    - `inserted_at`: The timestamp when the food item was created.
    - `updated_at`: The timestamp when the food item was last updated.
  """
  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          category_id: integer(),
          category: Category.t(),
          food_measures: [FoodMeasure.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "foods" do
    field :name, :string

    belongs_to :category, Category

    has_many :food_measures, FoodMeasure

    timestamps()
  end
end
