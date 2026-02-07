# Queries

## foodCategories

Type: [FoodCategory](objects.html#foodcategory)

Get all food categories

| field | description |
| ----- | ----------- |


```gql
query FoodCategories {
  foodCategories {
    foods
    id
    name
  }
}
```


## foods

Type: [Food](objects.html#food)

Get all foods

| field | description |
| ----- | ----------- |


```gql
query Foods {
  foods {
    foodCategory {
    }
    foodMeasures
    id
    name
  }
}
```


## meals

Type: [Meal](objects.html#meal)

Get all meals

| field | description |
| ----- | ----------- |


```gql
query Meals {
  meals {
    id
    mealIngredients
    name
  }
}
```


