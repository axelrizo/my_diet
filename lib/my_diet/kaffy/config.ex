defmodule MyDiet.Kaffy.Config do
  def create_resources(_conn) do
    [
      food: [
        resources: [
          food_category: [schema: MyDiet.Foods.FoodCategories.FoodCategory],
          food: [schema: MyDiet.Foods.Food],
          food_measures: [schema: MyDiet.Foods.FoodMeasures.FoodMeasure]
        ]
      ],
      meal: [
        resources: [
          meal: [schema: MyDiet.Meals.Meal],
          meal_ingredients: [schema: MyDiet.Meals.MealIngredients.MealIngredient]
        ]
      ],
      diet: [
        resources: [
          diet: [schema: MyDiet.Diets.Diet],
          diet_meals: [schema: MyDiet.Diets.DietMeals.DietMeal]
        ]
      ]
    ]
  end
end
