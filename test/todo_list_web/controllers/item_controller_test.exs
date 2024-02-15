defmodule TodoListWeb.ItemControllerTest do
  use TodoListWeb.ConnCase
  alias TodoList.Todo

  import TodoList.TodoFixtures

  @create_attrs %{person_id: 42, status: 0, text: "some text"}
  # @public_create_attrs %{person_id: 0, status: 0, text: "some public text"}
  # @completed_attrs %{person_id: 42, status: 1, text: "some text completed"}
  # @public_completed_attrs %{person_id: 0, status: 1, text: "some public text completed"}
  @update_attrs %{person_id: 43, status: 1, text: "some updated text"}
  @invalid_attrs %{person_id: nil, status: nil, text: nil}
  @invalid_attrs2 %{person_id: nil, status: nil, text: nil, priority: nil}
  @new_attrs %{person_id: 42, status: 0, text: "some", priority: 1}
  @new_attrs_2 %{person_id: 43, status: 0, text: "some", priority: 2}

  # creato attributi per test
  # modificato create_item con attributi nuovi
  # create funzioni di creazione nuovo item
  # aggiornato update e altre funzioni con i nuovi valori
  # attualmente test: 22 ok, 0 fails

  # da sistemare update per priority se si vuole modificare

  describe "index" do
    test "lists all items", %{conn: conn} do
      conn = get(conn, ~p"/items")
      assert html_response(conn, 200) =~ "todos"
    end
  end

  describe "new item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/items/new")
      assert html_response(conn, 200) =~ "what needs to be done?"
    end
  end

  # commentato in attesa di modifica

  # describe "create item" do
  #   test "redirects to show when data is valid", %{conn: conn} do
  #     conn = post(conn, ~p"/items", item: @create_attrs)

  #     assert %{} = redirected_params(conn)
  #     assert redirected_to(conn) == ~p"/items/"
  #   end

  #   test "errors when invalid attributes are passed", %{conn: conn} do
  #     conn = post(conn, ~p"/items", item: @invalid_attrs)
  #     assert html_response(conn, 200) =~ "can&#39;t be blank"
  #   end
  # end

  describe "edit item" do
    setup [:create_item]

    test "renders form for editing chosen item", %{conn: conn, item: item} do
      conn = get(conn, ~p"/items/#{item}/edit")
      assert html_response(conn, 200) =~ item.text
    end
  end

  describe "update item" do
    setup [:create_item]

    test "redirects when data is valid", %{conn: conn, item: item} do
      conn = put(conn, ~p"/items/#{item}", item: @update_attrs)
      assert redirected_to(conn) == ~p"/items"

      conn = get(conn, ~p"/items/#{item}")
      assert html_response(conn, 200) =~ "some updated text"
    end

    test "renders errors when data is invalid", %{conn: conn, item: item} do
      conn = put(conn, ~p"/items/#{item}", item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Item"
    end
  end

  describe "delete item" do
    setup [:create_item]

    test "deletes chosen item", %{conn: conn, item: item} do
      conn = delete(conn, ~p"/items/#{item}")
      assert redirected_to(conn) == ~p"/items"

      assert_error_sent 404, fn ->
        get(conn, ~p"/items/#{item}")
      end
    end
  end

  describe "toggle updates the status of an item 0 > 1 | 1 > 0" do
    setup [:create_item]

    test "toggle_status/1 item.status 1 > 0", %{item: item} do
      assert item.status == 0
      # first toggle
      toggled_item = %{item | status: TodoListWeb.ItemController.toggle_status(item)}
      assert toggled_item.status == 1
      # second toggle sets status back to 0
      assert TodoListWeb.ItemController.toggle_status(toggled_item) == 0
    end

    test "toggle/2 updates an item.status 0 > 1", %{conn: conn, item: item} do
      assert item.status == 0
      get(conn, ~p'/items/toggle/#{item.id}')
      toggled_item = Todo.get_item!(item.id)
      assert toggled_item.status == 1
    end
  end

  # defp create_item(_) do
  #   item = item_fixture(@create_attrs)
  #   %{item: item}
  # end

  defp create_item(_) do
    item = item_fixture2(@new_attrs)
    %{item: item}
  end

  describe "create item with priority" do
    test "creare item with priority 1", %{conn: conn} do
      conn = post(conn, ~p"/items", item: @new_attrs)

      assert %{} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/items/"
    end

    test "error invalid attributes", %{conn: conn} do
      conn = post(conn, ~p"/items", item: @invalid_attrs2)
      assert html_response(conn, 200) =~ "can&#39;t be blank"
    end
  end
end
