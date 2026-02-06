defmodule MyDiet.Meals do
  @moduledoc """
  Meals context module responsible for managing meals and their related entities.
  """

  alias MyDiet.Repo

  @doc """
  Returns a Dataloader source for meals, which can be used to efficiently load associated data in GraphQL resolvers.
  """
  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  defp query(queryable, _params) do
    queryable
  end
end
