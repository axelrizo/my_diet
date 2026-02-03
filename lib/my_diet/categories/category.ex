defmodule MyDiet.Categories.Category do
  use Ecto.Schema

  schema "categories" do
    field :name, :string

    has_many :foods, MyDiet.Foods.Food

    timestamps()
  end
end
