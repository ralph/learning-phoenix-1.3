defmodule Rumbl.Web.VideoController do
  use Rumbl.Web, :controller

  alias Rumbl.Repo
  alias Rumbl.VideoContext
  alias Rumbl.VideoContext.Category

  plug :load_categories when action in [:new, :create, :edit, :update]

  def index(conn, _params, user) do
    videos = VideoContext.list_videos(user)
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params, user) do
    changeset =
      user
      |> Ecto.build_assoc(:videos)
      |> VideoContext.change_video()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}, user) do
    case VideoContext.create_video(video_params, user) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    video = VideoContext.get_video!(id, user)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}, user) do
    video = VideoContext.get_video!(id, user)
    changeset = VideoContext.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}, user) do
    video = VideoContext.get_video!(id, user)

    case VideoContext.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    video = VideoContext.get_video!(id, user)
    {:ok, _video} = VideoContext.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn), [conn, conn.params, conn.assigns.current_user])
  end

  defp load_categories(conn, _) do
    query =
      Category
      |> Category.names_and_ids
      |> Category.alphabetical
    categories = Repo.all(query)
    assign(conn, :categories, categories)
  end
end
