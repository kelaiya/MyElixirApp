defmodule App.GetImage do
  use App.Web, :model
  schema "image" do
    field :name, :string
  end
end