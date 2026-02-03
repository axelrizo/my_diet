defmodule MyDiet.Categories.Category do
  use Ecto.Schema

  schema "categories" do
    field :name, :string

    timestamps()
  end
end
