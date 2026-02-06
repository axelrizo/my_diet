defmodule MyDiet.Factories.Meals do
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
          quantity: sequence(:quantity, &Decimal.new(&1))
        }
      end

      def with_meal_ingredient(%Meal{} = meal) do
        food_measure = :food_measure |> build() |> with_food()
        meal_ingredient = insert(:meal_ingredient, meal: meal, food_measure: food_measure)

        %{meal | meal_ingredients: [meal_ingredient]}
      end
    end
  end
end
