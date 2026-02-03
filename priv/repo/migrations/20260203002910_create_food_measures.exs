defmodule MyDiet.Repo.Migrations.CreateFoodMeasures do
  use Ecto.Migration

  def change do
    create table(:food_measures) do
      add :portion, :string, null: false
      add :carbohydrates, :decimal, precision: 10, scale: 2, null: false
      add :fats, :decimal, precision: 10, scale: 2, null: false
      add :proteins, :decimal, precision: 10, scale: 2, null: false

      add :food_id, references(:foods, validate: false), null: false

      timestamps()
    end
  end
end
