# Objects

## Food

| field | description |
| ----- | ----------- |
| `foodCategory` ( [FoodCategory](objects.html#foodcategory) ) | The category this food belongs to |
| `foodMeasures` ( [\[FoodMeasure\]](objects.html#foodmeasure) ) | The different measures for this food, each with its own nutritional information |
| `id` ( [ID](scalars.html#id) ) | The unique identifier of the food |
| `name` ( [String!](scalars.html#string) ) | The name of the food |

## FoodCategory

| field | description |
| ----- | ----------- |
| `foods` ( [\[Food\]](objects.html#food) ) | The food items that belong to this category |
| `id` ( [ID](scalars.html#id) ) | The unique identifier of the food category |
| `name` ( [String!](scalars.html#string) ) | The name of the food category (e.g., 'Fruits', 'Vegetables', 'Grains') |

## FoodMeasure

| field | description |
| ----- | ----------- |
| `carbohydrates` ( [Decimal!](scalars.html#decimal) ) | Carbohydrates in grams for this measure of the food |
| `fats` ( [Decimal!](scalars.html#decimal) ) | Fats in grams for this measure of the food |
| `food` ( [Food](objects.html#food) ) | The food that this measure belongs to |
| `id` ( [ID](scalars.html#id) ) | The unique identifier of the food measure |
| `mealIngredients` ( [\[MealIngredient\]](objects.html#mealingredient) ) | The meal ingredients that use this food measure |
| `portion` ( [String!](scalars.html#string) ) | The name of the measure (e.g., 'cup', 'slice', 'piece') |
| `proteins` ( [Decimal!](scalars.html#decimal) ) | Proteins in grams for this measure of the food |

## Meal

| field | description |
| ----- | ----------- |
| `id` ( [ID](scalars.html#id) ) | The unique identifier of the meal |
| `mealIngredients` ( [\[MealIngredient\]](objects.html#mealingredient) ) | The ingredients that make up this meal, each with a specific food measure and quantity |
| `name` ( [String!](scalars.html#string) ) | The name of the meal (e.g., 'Eggs and Toast', 'Chicken Salad') |

## MealIngredient

| field | description |
| ----- | ----------- |
| `foodMeasure` ( [FoodMeasure](objects.html#foodmeasure) ) | The meal that this ingredient belongs to |
| `id` ( [ID](scalars.html#id) ) | The unique identifier of the meal ingredient |
| `quantity` ( [Decimal!](scalars.html#decimal) ) | The quantity of the food measure used in this meal ingredient (e.g., 2 for 2 cups) |

