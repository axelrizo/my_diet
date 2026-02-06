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
      %{food_measures: [food_measure]} = :food |> insert() |> with_food_measure()

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

  describe "query: meals" do
    test "returns a list of meals", %{conn: conn} do
      meal = insert(:meal)

      query = "{ meals { id name } }"

      assert %{"meals" => [meal_data]} = query_graphql(conn, query)

      assert int_equal?(meal.id, meal_data["id"])
      assert meal.name == meal_data["name"]
    end

    test "returns meal ingredient relation", %{conn: conn} do
      %{meal_ingredients: [meal_ingredient]} = :meal |> insert() |> with_meal_ingredient()

      query = "{ meals { mealIngredients { id quantity } } }"

      assert %{"meals" => [meal_data]} = query_graphql(conn, query)
      assert %{"mealIngredients" => [meal_ingredient_data]} = meal_data

      assert int_equal?(meal_ingredient.id, meal_ingredient_data["id"])
      assert decimal_equal?(meal_ingredient.quantity, meal_ingredient_data["quantity"])
    end

    test "returns food measure relation", %{conn: conn} do
      %{meal_ingredients: [%{food_measure: food_measure}]} =
        :meal |> insert() |> with_meal_ingredient()

      query =
        "{ meals { mealIngredients { foodMeasure { id portion proteins carbohydrates fats } } } }"

      assert %{"meals" => [meal_data]} = query_graphql(conn, query)
      assert %{"mealIngredients" => [meal_ingredient_data]} = meal_data
      assert %{"foodMeasure" => food_measure_data} = meal_ingredient_data

      assert int_equal?(food_measure.id, food_measure_data["id"])
      assert food_measure.portion == food_measure_data["portion"]
      assert decimal_equal?(food_measure.proteins, food_measure_data["proteins"])
      assert decimal_equal?(food_measure.carbohydrates, food_measure_data["carbohydrates"])
      assert decimal_equal?(food_measure.fats, food_measure_data["fats"])
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
