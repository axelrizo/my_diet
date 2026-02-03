defmodule MyDiet.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create table(:foods) do
      add :name, :string, null: false

      add :category_id, references(:categories, validate: false)

      timestamps()
    end

    create unique_index(:foods, [:name], concurrently: true)
  end
end
