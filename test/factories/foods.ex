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
          portion: sequence(:portion, &"#{&1}g"),
          carbohydrates: sequence(:carbohydrates, &Decimal.new("#{&1}.0")),
          fats: sequence(:fats, &Decimal.new("#{&1}.0")),
          proteins: sequence(:proteins, &Decimal.new("#{&1}.0"))
        }
      end

      def with_food(%FoodCategory{} = food_category) do
        food = insert(:food, food_category: food_category)

        %{food_category | foods: [food]}
      end

      def with_food(%FoodMeasure{} = food_measure) do
        food_category = insert(:food_category)
        food = insert(:food, food_measures: [food_measure], food_category: food_category)

        %{food_measure | food: food}
      end

      def with_food_measure(%Food{} = food) do
        food_measure = insert(:food_measure, food: food)

        %{food | food_measures: [food_measure]}
      end
    end
  end
end
