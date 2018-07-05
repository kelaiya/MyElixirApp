defmodule AppWeb.ImageController do
	use AppWeb, :controller

	def index(conn, _params) do
		images = App.Repo.all(App.Image)
		json conn, images
	end
end