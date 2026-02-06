defmodule MyDiet.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: MyDiet.Repo
  use MyDiet.Factories.Foods
  use MyDiet.Factories.Meals
end
