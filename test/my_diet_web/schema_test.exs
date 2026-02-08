defmodule MyDietWeb.SchemaTest do
  use MyDietWeb.ConnCase, async: true

  import AbsintheErrorPayload.TestHelper

  alias AbsintheErrorPayload.ValidationMessage
  alias MyDiet.Foods.FoodCategories.FoodCategory

  describe "query: foods" do
    test "returns food list", %{conn: conn} do
      food = insert(:food)

      query = "{ foods { id name } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [result]} = data

      fields = %{id: :number, name: :string}
      expected = food
      assert_equivalent_graphql(expected, result, fields)
    end

    test "returns food category relation", %{conn: conn} do
      food_category = insert(:food_category)
      insert(:food, food_category: food_category)

      query = "{ foods { foodCategory { id name } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [food]} = data
      assert %{"foodCategory" => result} = food

      fields = %{id: :number, name: :string}
      expected = food_category
      assert_equivalent_graphql(expected, result, fields)
    end

    test "returns food measures relation", %{conn: conn} do
      food_measure = insert(:food_measure)

      query = "{ foods { foodMeasures { id portion proteins carbohydrates fats } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [food_data]} = data
      assert %{"foodMeasures" => [result]} = food_data

      fields = %{
        id: :number,
        portion: :number,
        proteins: :float,
        carbohydrates: :float,
        fats: :float
      }

      expected = %{
        food_measure
        | proteins: Decimal.to_float(food_measure.proteins),
          carbohydrates: Decimal.to_float(food_measure.carbohydrates),
          fats: Decimal.to_float(food_measure.fats)
      }

      assert_equivalent_graphql(expected, result, fields)
    end

    test "returns meal ingredients relation", %{conn: conn} do
      meal_ingredient = insert(:meal_ingredient)

      query = "{ foods { name foodMeasures { id portion mealIngredients { id quantity } } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [food_data]} = data
      assert %{"foodMeasures" => [food_measures_data]} = food_data
      assert %{"mealIngredients" => [result]} = food_measures_data

      expected = %{meal_ingredient | quantity: Decimal.to_float(meal_ingredient.quantity)}

      fields = %{id: :number, quantity: :float}
      assert_equivalent_graphql(expected, result, fields)
    end
  end

  describe "query: foodCategories" do
    test "returns food category list", %{conn: conn} do
      food_category = insert(:food_category)

      query = "{ foodCategories { id name } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foodCategories" => [result]} = data

      expected = food_category
      fields = %{id: :number, name: :string}
      assert_equivalent_graphql(expected, result, fields)
    end

    test "returns food relation", %{conn: conn} do
      food = insert(:food)

      query = "{ foodCategories { foods { id name } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foodCategories" => [food_category_data]} = data
      assert %{"foods" => [result]} = food_category_data

      expected = food
      fields = %{id: :number, name: :string}
      assert_equivalent_graphql(expected, result, fields)
    end
  end

  describe "query: meals" do
    test "returns a list of meals", %{conn: conn} do
      meal = insert(:meal)

      query = "{ meals { id name } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"meals" => [result]} = data

      expected = meal
      fields = %{id: :number, name: :string}
      assert_equivalent_graphql(expected, result, fields)
    end

    test "returns meal ingredient relation", %{conn: conn} do
      meal_ingredient = insert(:meal_ingredient)

      query = "{ meals { mealIngredients { id quantity } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"meals" => [meal_data]} = data
      assert %{"mealIngredients" => [result]} = meal_data

      expected = %{
        meal_ingredient
        | quantity: Decimal.to_float(meal_ingredient.quantity)
      }

      fields = %{id: :number, quantity: :float}
      assert_equivalent_graphql(expected, result, fields)
    end

    test "returns food measure relation", %{conn: conn} do
      %{food_measure: food_measure} = insert(:meal_ingredient)

      query =
        "{ meals { mealIngredients { foodMeasure { id portion proteins carbohydrates fats } } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"meals" => [meal_data]} = data
      assert %{"mealIngredients" => [meal_ingredient_data]} = meal_data
      assert %{"foodMeasure" => result} = meal_ingredient_data

      fields = %{
        id: :number,
        portion: :string,
        proteins: :float,
        carbohydrates: :float,
        fats: :float
      }

      expected = %{
        food_measure
        | proteins: Decimal.to_float(food_measure.proteins),
          carbohydrates: Decimal.to_float(food_measure.carbohydrates),
          fats: Decimal.to_float(food_measure.fats)
      }

      assert_equivalent_graphql(expected, result, fields)
    end
  end

  describe "mutation: createFoodCategory" do
    test "creates a new food category", %{conn: conn} do
      food_name = "New Category"

      query = """
        mutation { createFoodCategory(name: \"#{food_name}\") {
            successful
            messages { field message code }
            result { id name }
        }}
      """

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"createFoodCategory" => payload} = data

      fields = %{name: :string}
      expected = %FoodCategory{name: food_name}
      assert_mutation_success(expected, payload, fields)
    end

    test "returns error for duplicate food category", %{conn: conn} do
      food_category = insert(:food_category)

      query = """
      mutation { createFoodCategory(name: "#{food_category.name}") {
          successful
          messages { field message code }
          result { id name }
      }}
      """

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"createFoodCategory" => payload} = data

      expected = %ValidationMessage{
        code: :unique,
        field: :name,
        message: "has already been taken"
      }

      assert_mutation_failure([expected], payload, [:field, :message, :code])
    end
  end

  defp run_graphql_request(conn, query_params) do
    conn
    |> post("/api", query_params)
    |> json_response(200)
  end
end
