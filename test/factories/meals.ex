defmodule MyDiet.Factories.Meals do
  @moduledoc false

  alias MyDiet.Meals.Meal
  alias MyDiet.Meals.MealIngredients.MealIngredient

  defmacro __using__(_opts) do
    quote do
      def meal_factory do
        %Meal{
          name: sequence(:name, &"Meal_#{&1}")
        }
      end

      def meal_ingredient_factory do
        %MealIngredient{
          quantity: sequence(:quantity, &Decimal.new(&1), start_at: 1),
          food_measure: build(:food_measure),
          meal: build(:meal)
        }
      end
    end
  end
end
