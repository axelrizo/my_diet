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

## FoodCategoryPayload

| field | description |
| ----- | ----------- |
| `messages` ( [\[ValidationMessage\]](objects.html#validationmessage) ) | A list of failed validations. May be blank or null if mutation succeeded. |
| `result` ( [FoodCategory](objects.html#foodcategory) ) | The object created/updated/deleted by the mutation. May be null if mutation failed. |
| `successful` ( [Boolean!](scalars.html#boolean) ) | Indicates if the mutation completed successfully or not. |

## FoodMeasure

| field | description |
| ----- | ----------- |
| `carbohydrates` ( [Float!](scalars.html#float) ) | Carbohydrates in grams for this measure of the food |
| `fats` ( [Float!](scalars.html#float) ) | Fats in grams for this measure of the food |
| `food` ( [Food](objects.html#food) ) | The food that this measure belongs to |
| `id` ( [ID](scalars.html#id) ) | The unique identifier of the food measure |
| `mealIngredients` ( [\[MealIngredient\]](objects.html#mealingredient) ) | The meal ingredients that use this food measure |
| `portion` ( [String!](scalars.html#string) ) | The name of the measure (e.g., 'cup', 'slice', 'piece') |
| `proteins` ( [Float!](scalars.html#float) ) | Proteins in grams for this measure of the food |

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
| `quantity` ( [Float!](scalars.html#float) ) | The quantity of the food measure used in this meal ingredient (e.g., 2 for 2 cups) |

## ValidationMessage

| field | description |
| ----- | ----------- |
| `code` ( [String!](scalars.html#string) ) | A unique error code for the type of validation used. |
| `field` ( [String](scalars.html#string) ) | The input field that the error applies to. The field can be used to
identify which field the error message should be displayed next to in the
presentation layer.

If there are multiple errors to display for a field, multiple validation
messages will be in the result.

This field may be null in cases where an error cannot be applied to a specific field. |
| `message` ( [String](scalars.html#string) ) | A friendly error message, appropriate for display to the end user.

The message is interpolated to include the appropriate variables.

Example: `Username must be at least 10 characters`

This message may change without notice, so we do not recommend you match against the text.
Instead, use the *code* field for matching. |
| `options` ( [\[ValidationOption\]](objects.html#validationoption) ) | A list of substitutions to be applied to a validation message template |
| `template` ( [String](scalars.html#string) ) | A template used to generate the error message, with placeholders for option substitution.

Example: `Username must be at least {count} characters`

This message may change without notice, so we do not recommend you match against the text.
Instead, use the *code* field for matching. |

## ValidationOption

| field | description |
| ----- | ----------- |
| `key` ( [String!](scalars.html#string) ) | The name of a variable to be substituted in a validation message template |
| `value` ( [String!](scalars.html#string) ) | The value of a variable to be substituted in a validation message template |

