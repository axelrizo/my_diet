defmodule MyDiet.Diets.Diet do
  use Ecto.Schema

  schema "diets" do
    field :name, :string

    timestamps()
  end
end
