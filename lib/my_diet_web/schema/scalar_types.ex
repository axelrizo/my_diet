defmodule MyDietWeb.Schema.ScalarTypes do
  use Absinthe.Schema.Notation

  scalar :decimal, description: "A decimal value" do
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
