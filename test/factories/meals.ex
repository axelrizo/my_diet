defmodule MyDiet.Factories.Meals do
  defmacro __using__(_opts) do
    quote do
      def meal_factory do
        %MyDiet.Meals.Meal{
          name: sequence(:name, &"Meal_#{&1}")
        }
      end

      def meal_ingredient_factory do
        %MyDiet.Meals.MealIngredients.MealIngredient{
          quantity: 150
        }
      end
    end
  end
end
