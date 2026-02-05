defmodule MyDiet.Factory do
  use ExMachina.Ecto, repo: MyDiet.Repo
  use MyDiet.Factories.Foods
  use MyDiet.Factories.Meals
end
