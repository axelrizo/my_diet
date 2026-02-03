defmodule MyDiet.Repo.Migrations.CreateDiets do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create table(:diets) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:diets, [:name], concurrently: true)

    create table(:diet_plans) do
      add :quantity, :decimal, precision: 10, scale: 2, null: false

      add :meal_id, references(:meals, validate: false), null: false
      add :diet_id, references(:diets, validate: false), null: false

      timestamps()
    end

    create unique_index(:diet_plans, [:diet_id, :meal_id], concurrently: true)
  end
end
