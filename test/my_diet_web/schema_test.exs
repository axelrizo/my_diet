defmodule MyDietWeb.SchemaTest do
  use MyDietWeb.ConnCase, async: true

  describe "query: foods" do
    test "returns food list", %{conn: conn} do
      food = insert(:food)

      query = "{ foods { id name } }"

      assert %{"foods" => [food_data]} = query_graphql(conn, query)

      assert food.id == String.to_integer(food_data["id"])
      assert food.name == food_data["name"]
    end

    test "returns food category relation", %{conn: conn} do
      food_category = :food_category |> insert() |> with_food()

      query = "{ foods { foodCategory { id name } } }"

      assert %{"foods" => [food]} = query_graphql(conn, query)
      assert %{"foodCategory" => food_category_data} = food

      assert food_category.id == String.to_integer(food_category_data["id"])
      assert food_category.name == food_category_data["name"]
    end

    test "returns food measures relation", %{conn: conn} do
      %{food_measures: [food_measure]} = insert(:food, food_measures: [build(:food_measure)])

      query = "{ foods { foodMeasures { id portion proteins carbohydrates fats } } }"

      assert %{"foods" => [food_data]} = query_graphql(conn, query)
      assert %{"foodMeasures" => [food_measures_data]} = food_data

      assert food_measure.id == String.to_integer(food_measures_data["id"])
      assert food_measure.portion == food_measures_data["portion"]
      assert_decimal_equal?(food_measure.proteins, food_measures_data["proteins"])
      assert_decimal_equal?(food_measure.carbohydrates, food_measures_data["carbohydrates"])
      assert_decimal_equal?(food_measure.fats, food_measures_data["fats"])
    end

    @query """
    {
      foods {
        id
        name
        foodCategory {
          id
          name
        }
        foodMeasures {
          id
          portion
          fats
          carbohydrates
          proteins
          mealIngredients {
            id
          }
        }
      }
    }
    """

    test "returns a list of all foods", %{conn: conn} do
      :food_category
      |> insert()
      |> with_food()

      conn = post(conn, "/api", %{"query" => @query})

      response = json_response(conn, 200)

      assert %{"data" => %{"foods" => foods}} = response
      assert length(foods) == 2

      assert Enum.all?(foods, fn food ->
               Map.has_key?(food, "id") and
                 Map.has_key?(food, "name") and
                 Map.has_key?(food, "foodCategory")
             end)
    end

    test "returns a list of all foods categories", %{conn: conn} do
      food_category = insert(:food_category)

      insert(:food, %{
        name: "Apple",
        food_category: food_category,
        food_measures: build_list(2, :food_measure)
      })

      insert(:food, %{
        name: "Banana",
        food_category: food_category,
        food_measures: build_list(2, :food_measure)
      })

      conn = post(conn, "/api", %{"query" => @query})

      _response = json_response(conn, 200)
    end
  end

  describe "query: allMeals" do
    @query """
    {
      meals {
        name
        mealIngredients {
          id
          foodMeasure {
            id
          }
        }
      }
    }
    """

    test "returns a list of all meals", %{conn: conn} do
      meal1 = insert(:meal, %{name: "Breakfast"})
      meal2 = insert(:meal, %{name: "Lunch"})
      food_measure = insert(:food_measure, %{food: build(:food)})
      food_measure2 = insert(:food_measure, %{food: build(:food)})

      insert(:meal_ingredient, %{meal: meal1, food_measure: food_measure, quantity: 100})
      insert(:meal_ingredient, %{meal: meal2, food_measure: food_measure2, quantity: 200})

      conn = post(conn, "/api", %{"query" => @query})

      _response = json_response(conn, 200)
    end
  end

  defp query_graphql(conn, query) do
    conn
    |> post("/api", %{"query" => query})
    |> json_response(200)
    |> Map.fetch!("data")
  end

  defp assert_decimal_equal?(decimal_1, decimal_2) do
    Decimal.equal?(decimal_1, Decimal.new(decimal_2))
  end
end
