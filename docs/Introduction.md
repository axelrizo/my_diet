# Introduction

## Food

We store foods in the table `foods` and we don't relate them directly with its `carbohydrates`, `fats` and `proteins` because we want to be able of create foods easily by just know what the foods labels has, sometimes commercial foods are just labeled with fixed amounts as `2 slices`, `1 portion`, `1 can`, etc... so having it decoupled we can classify the main food in their own category what is it, if is `meat`, `fruit`, `vegetable` or `dairy`.

At the end we have tables like this:

```mermaid
erDiagram
  categories ||--o{ foods : has
  foods ||--o{ food_measures : has
  categories{
    int id PK
    string name "i.e ('dairy', 'fruit')"
  }
  foods{
    int id PK
    int category_id FK
    string name "i.e. ('apple')"
  }
  food_measures{
    int id PK
    int food_id FK
    string portion "i.e ('large', 'can', 'slice', 'gram')"
    decimal carbohydrates
    decimal fats
    decimal proteins
  }
```

In this way we can calculate the total calories of combination of foods to create meals and for making the shopping list we also know which category belongs each food.

## Meals

A meal is just a combination of foods, but in this case is going to be related with a food measure to know the total that we need of each either to count the calories or create the shopping list.

```mermaid
erDiagram
  food_measures ||--|| meals_food_measures : "is composed by"
  meals_food_measures ||--|| meals : "is composed by"
  meals_food_measures{
    int id PK
    int meal_id FK
    int food_measure_id FK
    decimal quantity "amount of that food measure"
  }
  meals{
    int id PK
    string name "i.e ('sandwich')"
  }
```

## Diets
