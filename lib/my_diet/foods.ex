defmodule MyDiet.Foods do
  @moduledoc """
  Foods context for managing food-related data and operations.
  """

  alias MyDiet.Repo

  @doc """
  Returns a Dataloader source for foods, which can be used to efficiently load associated data in GraphQL resolvers.
  """
  def data do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  defp query(queryable, _params) do
    queryable
  end
end
