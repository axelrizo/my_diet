# Mutations

## createFoodCategory

Type: [FoodCategoryPayload](objects.html#foodcategorypayload)

Create a new food category

| field | description |
| ----- | ----------- |
| `name` ( [String!](scalars.html#string) ) | Name of the food category, e.g., 'Fruits', 'Vegetables', Must be unique. |

```gql
mutation CreateFoodCategory($name: String!) {
  createFoodCategory(name: $name) {
    messages
    result {
    }
    successful
  }
}
```


