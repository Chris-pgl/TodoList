defmodule TodoListWeb.ItemHTML do
  use TodoListWeb, :html

  embed_templates "item_html/*"

  @doc """
  Renders a item form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def item_form(assigns)

  def complete(item) do
    case item.status do
      1 -> "completed"
      _ -> ""
    end
  end

  # returns integer value of items where item.status == 0 (not "done")
  def remaining_items(items) do
    Enum.filter(items, fn i -> i.status == 0 end) |> Enum.count()
  end

  def filter(items, str) do
    case str do
      "all" -> items
      "active" -> Enum.filter(items, fn i -> i.status == 0 end)
      "completed" -> Enum.filter(items, fn i -> i.status == 1 end)
    end
  end

  def selected(filter, str) do
    case filter == str do
      true -> "selected"
      false -> ""
    end
  end

  def pluralise(items) do
    case remaining_items(items) == 0 || remaining_items(items) > 1 do
      true -> "items"
      false -> "item"
    end
  end
end
