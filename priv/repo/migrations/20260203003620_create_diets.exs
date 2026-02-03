defmodule MyDiet.Repo.Migrations.CreateDiets do
  use Ecto.Migration

  def change do
    create table(:diets) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:diets, [:name])

    create table(:diets_meals) do
      add :quantity, :decimal, precision: 10, scale: 2, null: false

      add :meal_id, references(:meals), null: false
      add :diet_id, references(:diets), null: false

      timestamps()
    end
  end
end
