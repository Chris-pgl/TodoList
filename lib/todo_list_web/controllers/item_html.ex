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
end
