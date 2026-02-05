defmodule MyDiet.Factories.Foods do
  defmacro __using__(_opts) do
    quote do
      def food_factory do
        %MyDiet.Foods.Food{
          name: sequence(:name, &"Food_#{&1}")
        }
      end

      def food_category_factory do
        %MyDiet.Foods.FoodCategories.FoodCategory{
          name: sequence(:name, &"Food_Category_#{&1}")
        }
      end

      def food_measure_factory do
        %MyDiet.Foods.FoodMeasures.FoodMeasure{
          portion: "100g",
          carbohydrates: Decimal.new("10.0"),
          fats: Decimal.new("5.0"),
          proteins: Decimal.new("7.0")
        }
      end
    end
  end
end
