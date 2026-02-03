defmodule MyDiet.Foods.Food do
  use Ecto.Schema

  schema "foods" do
    field :name, :string

    belongs_to :category, MyDiet.Categories.Category

    timestamps()
  end
end
