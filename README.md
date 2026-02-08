# MyDiet

![Elixir](https://img.shields.io/badge/elixir-%234B275F.svg?style=for-the-badge&logo=elixir&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Phoenix Framework](https://img.shields.io/badge/phoenixframework-%23FD4F00.svg?style=for-the-badge&logo=phoenixframework&logoColor=black)
![GraphQL](https://img.shields.io/badge/-GraphQL-E10098?style=for-the-badge&logo=graphql&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)
![Ecto](https://img.shields.io/badge/Ecto-%2328a745.svg?style=for-the-badge&logo=elixir&logoColor=white)

[![CI](https://github.com/axelrizo/my_diet/actions/workflows/ci.yml/badge.svg)](https://github.com/axelrizo/my_diet/actions/workflows/ci.yml)
[![Deploy to Production](https://github.com/axelrizo/my_diet/actions/workflows/fly-deploy.yml/badge.svg)](https://github.com/axelrizo/my_diet/actions/workflows/fly-deploy.yml)
[![Last Updated](https://img.shields.io/github/last-commit/axelrizo/my_diet.svg)](https://github.com/axelrizo/my_diet/commits/main)

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
