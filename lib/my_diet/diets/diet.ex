defmodule MyDiet.Diets.Diet do
  @moduledoc """
  Represents a diet in the system.
  """

  use Ecto.Schema

  alias MyDiet.Diets.DietMeals.DietMeal

  @typedoc """
  Represents a diet in the system.
  ## Fields

    - `id`: The unique identifier for the diet.
    - `name`: The name of the diet.
    - `diet_meals`: List of associated `DietMeal` structs.
    - `inserted_at`: The timestamp when the diet was created.
    - `updated_at`: The timestamp when the diet was last updated.
  """
  @type t :: %__MODULE__{
          id: integer(),
          name: String.t(),
          diet_meals: [DietMeal.t()],
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "diets" do
    field :name, :string

    has_many :diet_meals, DietMeal

    timestamps()
  end
end
