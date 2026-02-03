defmodule MyDiet.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:meals, [:name])

    create table(:meals_food_measures) do
      add :quantity, :decimal, precision: 10, scale: 2, null: false

      add :meal_id, references(:meals), null: false
      add :food_measure_id, references(:food_measures), null: false

      timestamps()
    end

    create unique_index(:meals_food_measures, [:meal_id, :food_measure_id])
  end
end
