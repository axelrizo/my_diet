defmodule MyDiet.Meals do
  def data() do
    Dataloader.Ecto.new(MyDiet.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
