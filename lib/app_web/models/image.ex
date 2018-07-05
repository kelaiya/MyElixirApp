defmodule App.Image do
  use Ecto.Schema
  schema "images" do
    field :name, :string
  end
  @derive {Poison.Encoder, only: [:name]}
end