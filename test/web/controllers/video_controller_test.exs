defmodule Rumbl.Web.VideoControllerTest do
  use Rumbl.Web.ConnCase

  alias Rumbl.VideoContext

  @create_attrs %{description: "some description", title: "some title", url: "some url"}
  @update_attrs %{description: "some updated description", title: "some updated title", url: "some updated url"}
  @invalid_attrs %{description: nil, title: nil, url: nil}

  def fixture(:video) do
    {:ok, video} = VideoContext.create_video(@create_attrs)
    video
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, video_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Videos"
  end

  test "renders form for new videos", %{conn: conn} do
    conn = get conn, video_path(conn, :new)
    assert html_response(conn, 200) =~ "New Video"
  end

  test "creates video and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, video_path(conn, :create), video: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == video_path(conn, :show, id)

    conn = get conn, video_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Video"
  end

  test "does not create video and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, video_path(conn, :create), video: @invalid_attrs
    assert html_response(conn, 200) =~ "New Video"
  end

  test "renders form for editing chosen video", %{conn: conn} do
    video = fixture(:video)
    conn = get conn, video_path(conn, :edit, video)
    assert html_response(conn, 200) =~ "Edit Video"
  end

  test "updates chosen video and redirects when data is valid", %{conn: conn} do
    video = fixture(:video)
    conn = put conn, video_path(conn, :update, video), video: @update_attrs
    assert redirected_to(conn) == video_path(conn, :show, video)

    conn = get conn, video_path(conn, :show, video)
    assert html_response(conn, 200) =~ "some updated description"
  end

  test "does not update chosen video and renders errors when data is invalid", %{conn: conn} do
    video = fixture(:video)
    conn = put conn, video_path(conn, :update, video), video: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Video"
  end

  test "deletes chosen video", %{conn: conn} do
    video = fixture(:video)
    conn = delete conn, video_path(conn, :delete, video)
    assert redirected_to(conn) == video_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, video_path(conn, :show, video)
    end
  end
end
