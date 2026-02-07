defmodule MyDiet.Factories.Foods do
  @moduledoc false

  alias MyDiet.Foods.Food
  alias MyDiet.Foods.FoodCategories.FoodCategory
  alias MyDiet.Foods.FoodMeasures.FoodMeasure

  defmacro __using__(_opts) do
    quote do
      def food_category_factory do
        %FoodCategory{
          name: sequence(:name, &"Food_Category_#{&1}")
        }
      end

      def food_factory do
        %Food{
          name: sequence(:name, &"Food_#{&1}"),
          food_category: build(:food_category)
        }
      end

      def food_measure_factory do
        %FoodMeasure{
          portion: sequence(:portion, &"#{&1}g", start_at: 100),
          carbohydrates: sequence(:carbohydrates, &Decimal.new("#{&1}.0"), start_at: 100),
          fats: sequence(:fats, &Decimal.new("#{&1}.0"), start_at: 20),
          proteins: sequence(:proteins, &Decimal.new("#{&1}.0"), start_at: 30),
          food: build(:food)
        }
      end
    end
  end
end
