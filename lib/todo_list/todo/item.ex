defmodule TodoList.Todo.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :person_id, :integer, default: 0
    field :status, :integer, default: 0
    field :text, :string
    field :priority, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text, :person_id, :status, :priority])
    |> validate_required([:text])
  end
end
