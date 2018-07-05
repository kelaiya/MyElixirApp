defmodule App.Repo.Migrations.GetImage do
  use Ecto.Migration

  def change do
  	create table(:image) do
      add :name, :string
    end
  end
end
