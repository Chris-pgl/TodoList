defmodule TodoListWeb.ItemHtmlTest do
  use TodoListWeb.ConnCase, async: true
  alias TodoListWeb.ItemHTML

  test "complete/1 returns completed if item.status == 1" do
    assert ItemHTML.complete(%{status: 1}) == "completed"
  end

  test "complete/1 returns empty if item.status == 0" do
    assert ItemHTML.complete(%{status: 0}) == ""
  end
end
