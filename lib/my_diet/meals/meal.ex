defmodule MyDiet.Meals.Meal do
  use Ecto.Schema

  schema "meals" do
    field :name, :string

    timestamps()
  end
end
