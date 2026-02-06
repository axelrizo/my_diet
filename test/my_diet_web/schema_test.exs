defmodule MyDietWeb.SchemaTest do
  use MyDietWeb.ConnCase, async: true

  describe "query: foods" do
    test "returns food list", %{conn: conn} do
      food = insert(:food)

      query = " { foods { id name } } "

      assert %{"foods" => [returned_food]} = query_graphql(conn, query)

      assert food.id == String.to_integer(returned_food["id"])
      assert food.name == returned_food["name"]
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
end
