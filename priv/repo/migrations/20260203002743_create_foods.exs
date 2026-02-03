defmodule MyDiet.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  def change do
    create table(:foods) do
      add :name, :string, null: false

      add :category_id, references(:categories)

      timestamps()
    end

    create unique_index(:foods, [:name])
  end
end
