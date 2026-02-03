defmodule MyDiet.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create table(:meals) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:meals, [:name], concurrently: true)

    create table(:meals_food_measures) do
      add :quantity, :decimal, precision: 10, scale: 2, null: false

      add :meal_id, references(:meals, validate: false), null: false
      add :food_measure_id, references(:food_measures, validate: false), null: false

      timestamps()
    end

    create unique_index(:meals_food_measures, [:meal_id, :food_measure_id], concurrently: true)
  end
end
