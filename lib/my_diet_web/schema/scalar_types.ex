defmodule MyDietWeb.Schema.ScalarTypes do
  @moduledoc """
  This module defines custom scalar types for the GraphQL schema.
  """

  use Absinthe.Schema.Notation

  @desc "It represents a decimal value `Decimal` type from the `decimal` library. It can be used to represent precise decimal numbers."
  scalar :decimal do
    parse(fn
      %Absinthe.Blueprint.Input.String{value: value} ->
        case Decimal.parse(value) do
          {decimal, ""} -> {:ok, decimal}
          {_, _} -> :error
          :error -> :error
        end

      %Absinthe.Blueprint.Input.Float{value: value} ->
        {:ok, Decimal.from_float(value)}

      %Absinthe.Blueprint.Input.Integer{value: value} ->
        {:ok, Decimal.new(value)}

      _ ->
        :error
    end)

    serialize(fn decimal -> Decimal.to_string(decimal) end)
  end
end
