defmodule MyDietWeb.Schema do
  use Absinthe.Schema

  import_types(MyDietWeb.Schema.ScalarTypes)
  import_types(MyDietWeb.Schema.FoodsTypes)
  import_types(MyDietWeb.Schema.MealsTypes)

  alias MyDiet.Foods
  alias MyDiet.Meals
  alias MyDiet.Repo
  alias MyDietWeb.Resolvers

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Foods, Foods.data())
      |> Dataloader.add_source(Meals, Meals.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "Get all foods"
    field :foods, list_of(:food), resolve: &Resolvers.Foods.list_foods/3

    @desc "Get all food categories"
    field :food_categories, list_of(:food_category),
      resolve: &Resolvers.Foods.list_food_categories/3

    @desc "Get all meals"
    field :meals, list_of(:meal) do
      resolve(fn _parent, _args, _resolution ->
        {:ok, Repo.all(MyDiet.Meals.Meal)}
      end)
    end
  end
end
