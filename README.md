# MyDiet

A managing application to handle diets, generate shopping lists and else. You can measure your calories and organize your meal prep for the week.

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

You can read more about it in `/docs/` folder
