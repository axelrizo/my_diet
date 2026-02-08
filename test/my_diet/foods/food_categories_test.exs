defmodule MyDiet.Foods.FoodCategoriesTest do
  use MyDiet.DataCase, async: true

  alias Ecto.Changeset
  alias MyDiet.Foods.FoodCategories
  alias MyDiet.Foods.FoodCategories.FoodCategory

  describe "create/1" do
    test "creates the item in database" do
      attrs = %{name: "Fruits"}

      assert {:ok, food_category} = FoodCategories.create(attrs)

      assert %FoodCategory{} = food_category
      assert food_category.name == attrs.name
      assert Repo.get(FoodCategory, food_category.id)
    end

    test "returns error changeset for invalid attributes" do
      attrs = %{}

      assert {:error, %Changeset{valid?: false}} = FoodCategories.create(attrs)
    end

    test "validates uniqueness of name" do
      food_category = insert(:food_category)
      attrs = %{name: food_category.name}

      assert {:error, changeset} = FoodCategories.create(attrs)

      assert %Changeset{valid?: false} = changeset
      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end
  end
end
