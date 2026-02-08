defmodule MyDietWeb.SchemaTest do
  use MyDietWeb.ConnCase, async: true

  alias AbsintheErrorPayload.ValidationMessage
  alias MyDiet.Foods.FoodCategories.FoodCategory

  import AbsintheErrorPayload.TestHelper

  describe "query: foods" do
    test "returns food list", %{conn: conn} do
      food = insert(:food)

      query = "{ foods { id name } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [result]} = data

      fields = %{id: :number, name: :string}
      assert_equivalent_graphql(food, result, fields)
    end

    test "returns food category relation", %{conn: conn} do
      food_category = insert(:food_category)
      insert(:food, food_category: food_category)

      query = "{ foods { foodCategory { id name } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [food]} = data
      assert %{"foodCategory" => food_category_data} = food

      assert int_equal?(food_category.id, food_category_data["id"])
      assert food_category.name == food_category_data["name"]
    end

    test "returns food measures relation", %{conn: conn} do
      food_measure = insert(:food_measure)

      query = "{ foods { foodMeasures { id portion proteins carbohydrates fats } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [food_data]} = data
      assert %{"foodMeasures" => [food_measures_data]} = food_data

      assert int_equal?(food_measure.id, food_measures_data["id"])
      assert food_measure.portion == food_measures_data["portion"]
      assert decimal_equal?(food_measure.proteins, food_measures_data["proteins"])
      assert decimal_equal?(food_measure.carbohydrates, food_measures_data["carbohydrates"])
      assert decimal_equal?(food_measure.fats, food_measures_data["fats"])
    end

    test "returns meal ingredients relation", %{conn: conn} do
      meal_ingredient = insert(:meal_ingredient)

      query = "{ foods { name foodMeasures { id portion mealIngredients { id quantity } } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foods" => [food_data]} = data
      assert %{"foodMeasures" => [food_measures_data]} = food_data
      assert %{"mealIngredients" => [meal_ingredient_data]} = food_measures_data

      assert int_equal?(meal_ingredient.id, meal_ingredient_data["id"])
      assert decimal_equal?(meal_ingredient.quantity, meal_ingredient_data["quantity"])
    end
  end

  describe "query: foodCategories" do
    test "returns food category list", %{conn: conn} do
      food_category = insert(:food_category)

      query = "{ foodCategories { id name } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foodCategories" => [food_category_data]} = data

      assert int_equal?(food_category.id, food_category_data["id"])
      assert food_category.name == food_category_data["name"]
    end

    test "returns food relation", %{conn: conn} do
      food = insert(:food)

      query = "{ foodCategories { foods { id name } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"foodCategories" => [food_category_data]} = data

      assert %{"foods" => [food_data]} = food_category_data

      assert int_equal?(food.id, food_data["id"])
      assert food.name == food_data["name"]
    end
  end

  describe "query: meals" do
    test "returns a list of meals", %{conn: conn} do
      meal = insert(:meal)

      query = "{ meals { id name } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"meals" => [meal_data]} = data

      assert int_equal?(meal.id, meal_data["id"])
      assert meal.name == meal_data["name"]
    end

    test "returns meal ingredient relation", %{conn: conn} do
      meal_ingredient = insert(:meal_ingredient)

      query = "{ meals { mealIngredients { id quantity } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"meals" => [meal_data]} = data
      assert %{"mealIngredients" => [meal_ingredient_data]} = meal_data

      assert int_equal?(meal_ingredient.id, meal_ingredient_data["id"])
      assert decimal_equal?(meal_ingredient.quantity, meal_ingredient_data["quantity"])
    end

    test "returns food measure relation", %{conn: conn} do
      %{food_measure: food_measure} = insert(:meal_ingredient)

      query =
        "{ meals { mealIngredients { foodMeasure { id portion proteins carbohydrates fats } } } }"

      assert %{"data" => data} = run_graphql_request(conn, %{"query" => query})
      assert %{"meals" => [meal_data]} = data
      assert %{"mealIngredients" => [meal_ingredient_data]} = meal_data
      assert %{"foodMeasure" => food_measure_data} = meal_ingredient_data

      assert int_equal?(food_measure.id, food_measure_data["id"])
      assert food_measure.portion == food_measure_data["portion"]
      assert decimal_equal?(food_measure.proteins, food_measure_data["proteins"])
      assert decimal_equal?(food_measure.carbohydrates, food_measure_data["carbohydrates"])
      assert decimal_equal?(food_measure.fats, food_measure_data["fats"])
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

  defp decimal_equal?(%Decimal{} = decimal_1, decimal_2) when is_binary(decimal_2) do
    Decimal.equal?(decimal_1, Decimal.new(decimal_2))
  end

  defp int_equal?(id_1, id_2) when is_integer(id_1) and is_binary(id_2) do
    id_1 == String.to_integer(id_2)
  end
end
