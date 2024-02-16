defmodule TodoList.TodoTest do
  use TodoList.DataCase

  alias TodoList.Todo

  describe "items" do
    alias TodoList.Todo.Item

    import TodoList.TodoFixtures

    @invalid_attrs %{status: nil, text: nil, person_id: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Todo.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Todo.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{status: 42, text: "some text", person_id: 42, priority: 1}

      assert {:ok, %Item{} = item} = Todo.create_item(valid_attrs)
      assert item.status == 42
      assert item.text == "some text"
      assert item.person_id == 42
      assert item.priority == 1
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{status: 43, text: "some updated text", person_id: 43, priority: 2}

      assert {:ok, %Item{} = item} = Todo.update_item(item, update_attrs)
      assert item.status == 43
      assert item.text == "some updated text"
      assert item.person_id == 43
      assert item.priority == 2
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_item(item, @invalid_attrs)
      assert item == Todo.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Todo.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Todo.change_item(item)
    end
  end
end
