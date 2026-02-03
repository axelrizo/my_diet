defmodule MyDiet.Foods.FoodMeasures.FoodMeasure do
  use Ecto.Schema

  schema "food_measures" do
    field :portion, :string
    field :carbohydrates, :decimal
    field :fats, :decimal
    field :proteins, :decimal

    belongs_to :food, MyDiet.Foods.Food

    timestamps()
  end
end
