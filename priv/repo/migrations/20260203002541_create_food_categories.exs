defmodule MyDiet.Repo.Migrations.CreateFoodCategories do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create table(:food_categories) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:food_categories, [:name], concurrently: true)
  end
end
