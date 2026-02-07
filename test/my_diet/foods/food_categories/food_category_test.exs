defmodule MyDiet.Foods.FoodCategories.FoodCategoryTest do
  use MyDiet.DataCase, async: true

  alias Ecto.Changeset
  alias MyDiet.Foods.FoodCategories.FoodCategory

  describe "changeset/2" do
    test "returns valid changeset for valid attributes" do
      attrs = %{name: "Fruits"}

      changeset = FoodCategory.changeset(%FoodCategory{}, attrs)

      assert %Changeset{valid?: true} = changeset

      changes = changeset.changes
      assert changes.name == attrs.name
    end

    test "returns invalid changeset for missing required attributes" do
      attrs = %{}

      changeset = FoodCategory.changeset(%FoodCategory{}, attrs)

      assert %Changeset{valid?: false} = changeset

      assert errors_on(changeset)[:name] == ["can't be blank"]
    end
  end
end
