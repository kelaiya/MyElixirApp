defmodule App.Repo.Migrations.GetImage do
  use Ecto.Migration

  def change do
  	create table(:images) do
      add :name, :string
    end
  end
end
