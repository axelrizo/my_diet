defmodule MyDietWeb.SchemaTest do
  use MyDietWeb.ConnCase, async: true

  describe "query: foods" do
    test "returns food list", %{conn: conn} do
      food = insert(:food)

      query = "{ foods { id name } }"

      assert %{"foods" => [food_data]} = query_graphql(conn, query)

      assert int_equal?(food.id, food_data["id"])
      assert food.name == food_data["name"]
    end

    test "returns food category relation", %{conn: conn} do
      food_category = :food_category |> insert() |> with_food()

      query = "{ foods { foodCategory { id name } } }"

      assert %{"foods" => [food]} = query_graphql(conn, query)
      assert %{"foodCategory" => food_category_data} = food

      assert int_equal?(food_category.id, food_category_data["id"])
      assert food_category.name == food_category_data["name"]
    end

    test "returns food measures relation", %{conn: conn} do
      %{food_measures: [food_measure]} = insert(:food, food_measures: [build(:food_measure)])

      query = "{ foods { foodMeasures { id portion proteins carbohydrates fats } } }"

      assert %{"foods" => [food_data]} = query_graphql(conn, query)
      assert %{"foodMeasures" => [food_measures_data]} = food_data

      assert int_equal?(food_measure.id, food_measures_data["id"])
      assert food_measure.portion == food_measures_data["portion"]
      assert decimal_equal?(food_measure.proteins, food_measures_data["proteins"])
      assert decimal_equal?(food_measure.carbohydrates, food_measures_data["carbohydrates"])
      assert decimal_equal?(food_measure.fats, food_measures_data["fats"])
    end
  end

  describe "query: foodCategories" do
    test "returns food category list", %{conn: conn} do
      food_category = insert(:food_category)

      query = "{ foodCategories { id name } }"

      assert %{"foodCategories" => [food_category_data]} = query_graphql(conn, query)

      assert int_equal?(food_category.id, food_category_data["id"])
      assert food_category.name == food_category_data["name"]
    end

    test "returns food relation", %{conn: conn} do
      %{foods: [food]} = :food_category |> insert() |> with_food()

      query = "{ foodCategories { foods { id name } } }"

      assert %{"foodCategories" => [food_category_data]} = query_graphql(conn, query)
      assert %{"foods" => [food_data]} = food_category_data

      assert int_equal?(food.id, food_data["id"])
      assert food.name == food_data["name"]
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

  defp decimal_equal?(%Decimal{} = decimal_1, decimal_2) when is_binary(decimal_2) do
    Decimal.equal?(decimal_1, Decimal.new(decimal_2))
  end

  defp int_equal?(id_1, id_2) when is_integer(id_1) and is_binary(id_2) do
    id_1 == String.to_integer(id_2)
  end
end
