defmodule MyDiet.Factories.Foods do
  alias MyDiet.Foods.FoodCategories.FoodCategory
  alias MyDiet.Foods.FoodMeasures.FoodMeasure
  alias MyDiet.Foods.Food

  defmacro __using__(_opts) do
    quote do
      def food_factory do
        %Food{
          name: sequence(:name, &"Food_#{&1}")
        }
      end

      def food_category_factory do
        %FoodCategory{
          name: sequence(:name, &"Food_Category_#{&1}")
        }
      end

      def food_measure_factory do
        %FoodMeasure{
          portion: "100g",
          carbohydrates: Decimal.new("10.0"),
          fats: Decimal.new("5.0"),
          proteins: Decimal.new("7.0")
        }
      end

      def with_food(%FoodCategory{} = food_category) do
        food = insert(:food, food_category: food_category)
        %{food_category | foods: [food]}
      end
    end
  end
end
