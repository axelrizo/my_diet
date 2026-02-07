# Objects

## Food

| field | description |
| ----- | ----------- |
| `foodCategory` ( [FoodCategory](objects.html#foodcategory) ) |  |
| `foodMeasures` ( [\[FoodMeasure\]](objects.html#foodmeasure) ) |  |
| `id` ( [ID](scalars.html#id) ) |  |
| `name` ( [String!](scalars.html#string) ) |  |

## FoodCategory

| field | description |
| ----- | ----------- |
| `foods` ( [\[Food\]](objects.html#food) ) |  |
| `id` ( [ID](scalars.html#id) ) |  |
| `name` ( [String!](scalars.html#string) ) |  |

## FoodMeasure

| field | description |
| ----- | ----------- |
| `carbohydrates` ( [Decimal!](scalars.html#decimal) ) |  |
| `fats` ( [Decimal!](scalars.html#decimal) ) |  |
| `food` ( [Food](objects.html#food) ) |  |
| `id` ( [ID](scalars.html#id) ) |  |
| `mealIngredients` ( [\[MealIngredient\]](objects.html#mealingredient) ) |  |
| `portion` ( [String!](scalars.html#string) ) |  |
| `proteins` ( [Decimal!](scalars.html#decimal) ) |  |

## Meal

| field | description |
| ----- | ----------- |
| `id` ( [ID](scalars.html#id) ) |  |
| `mealIngredients` ( [\[MealIngredient\]](objects.html#mealingredient) ) |  |
| `name` ( [String!](scalars.html#string) ) |  |

## MealIngredient

| field | description |
| ----- | ----------- |
| `foodMeasure` ( [FoodMeasure](objects.html#foodmeasure) ) |  |
| `id` ( [ID](scalars.html#id) ) |  |
| `quantity` ( [Decimal!](scalars.html#decimal) ) |  |

