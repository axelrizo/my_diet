# MyDiet

A managing application to handle diets, generate shopping lists and else. You can measure your calories and organize your meal prep for the week.

- Links:
  - [Admin dashboard(DEMO)](https://my-diet-solitary-leaf-113.fly.dev/admin/)
  - [GraphQL Interface(DEMO)](https://my-diet-solitary-leaf-113.fly.dev/api/graphiql?query=query%20FoodCategories%20%7B%0A%20%20foodCategories%20%7B%0A%20%20%20%20foods%7B%0A%20%20%20%20%20%20__typename%0A%20%20%20%20%7D%0A%20%20%20%20id%0A%20%20%20%20name%0A%20%20%7D%0A%7D%0A%0Aquery%20Foods%20%7B%0A%20%20foods%20%7B%0A%20%20%20%20foodCategory%20%7B%0A%20%20%20%20%20%20__typename%0A%20%20%20%20%7D%0A%20%20%20%20foodMeasures%20%7B%0A%20%20%20%20%20%20__typename%0A%20%20%20%20%7D%0A%20%20%20%20id%0A%20%20%20%20name%0A%20%20%7D%0A%7D%0A%0Aquery%20Meals%20%7B%0A%20%20meals%20%7B%0A%20%20%20%20id%0A%20%20%20%20mealIngredients%7B%0A%20%20%20%20%20%20__typename%0A%20%20%20%20%7D%0A%20%20%20%20name%0A%20%20%7D%0A%7D)
  - [Online-Docs(DEMO)](https://my-diet-solitary-leaf-113.fly.dev/doc/readme.html)

## Tech Stack

- Elixir 1.19.5
- Erlang 28.3.1
- NodeJS 25.4.0

## Prerequisites

- Install [Docker](https://docs.docker.com/get-started/introduction/get-docker-desktop/)
- Install [asdf](https://asdf-vm.com/guide/introduction.html)

## Quick Setup

1. Enter with your console to the project folder then:
   ```bash
   asdf install
   ```
2. Run the containers
   ```bash
   docker compose up -d
   ```
3. Setup phoenix app
   ```bash
   make bootstrap
   ```
4. Run the phoenix server
   ```bash
   mix phx.server
   ```

## Docs

You can either read the [docs online](https://my-diet-solitary-leaf-113.fly.dev/doc/readme.html), check the folder /docs or generate them directly using:

```bash
mix docs --open
```
