defmodule MyDiet.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create table(:categories) do
      add :name, :string, null: false

      timestamps()
    end

    create unique_index(:categories, [:name], concurrently: true)
  end
end
