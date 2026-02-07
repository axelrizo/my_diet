defmodule MyDiet.Foods.FoodCategories.FoodCategory do
  @moduledoc """
  Represents a category of food items.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias MyDiet.Foods.Food

  @typedoc """
  Represents a category of food items.

  ## Fields

    - `id`: The unique identifier for the category.
    - `name`: The name of the category.
    - `foods`: A list of food items associated with this category.
    - `inserted_at`: The timestamp when the category was created.
    - `updated_at`: The timestamp when the category was last updated.
  """
  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          foods: [Food.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "food_categories" do
    field :name, :string

    has_many :foods, Food

    timestamps()
  end

  @doc false
  def changeset(food_category, attrs) do
    food_category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
