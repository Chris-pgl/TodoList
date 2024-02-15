defmodule TodoList.Repo.Migrations.ItemsAddPriorityColumnInteger do
  use Ecto.Migration

  def change do
    alter table("items") do
      add :priority, :integer
    end
  end
end
