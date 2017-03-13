defmodule Rumbl.Web.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.Repo
  alias Rumbl.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render conn, "show.html", user: user
  end
end
