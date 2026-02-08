defmodule MyDietWeb.Resolvers.Fields do
  @moduledoc """
  This module provides helper functions for resolving fields in the GraphQL schema.
  """

  @doc """
  Converts a Decimal field to a float.

  ## Examples

      iex> resolver = MyDietWeb.Resolvers.Fields.decimal_to_float(:fats)
      iex> resolver.(%{fats: Decimal.new("2.5")}, nil, nil)
      {:ok, 2.5}

  ## Example of usage in absinthe schema:

      field :fats, :float, resolve: Fields.decimal_to_float(:fats)
  """
  @spec decimal_to_float(atom()) :: (term(), term(), term() -> {:ok, float()})
  def decimal_to_float(field_name) do
    fn parent, _args, _resolution ->
      {:ok, parent |> Map.get(field_name) |> Decimal.to_float()}
    end
  end
end
