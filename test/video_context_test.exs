defmodule Rumbl.VideoContextTest do
  use Rumbl.DataCase

  alias Rumbl.VideoContext
  alias Rumbl.VideoContext.Video

  @create_attrs %{description: "some description", title: "some title", url: "some url"}
  @update_attrs %{description: "some updated description", title: "some updated title", url: "some updated url"}
  @invalid_attrs %{description: nil, title: nil, url: nil}

  def fixture(:video, attrs \\ @create_attrs) do
    {:ok, video} = VideoContext.create_video(attrs)
    video
  end

  test "list_videos/1 returns all videos" do
    video = fixture(:video)
    assert VideoContext.list_videos() == [video]
  end

  test "get_video! returns the video with given id" do
    video = fixture(:video)
    assert VideoContext.get_video!(video.id) == video
  end

  test "create_video/1 with valid data creates a video" do
    assert {:ok, %Video{} = video} = VideoContext.create_video(@create_attrs)
    
    assert video.description == "some description"
    assert video.title == "some title"
    assert video.url == "some url"
  end

  test "create_video/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = VideoContext.create_video(@invalid_attrs)
  end

  test "update_video/2 with valid data updates the video" do
    video = fixture(:video)
    assert {:ok, video} = VideoContext.update_video(video, @update_attrs)
    assert %Video{} = video
    
    assert video.description == "some updated description"
    assert video.title == "some updated title"
    assert video.url == "some updated url"
  end

  test "update_video/2 with invalid data returns error changeset" do
    video = fixture(:video)
    assert {:error, %Ecto.Changeset{}} = VideoContext.update_video(video, @invalid_attrs)
    assert video == VideoContext.get_video!(video.id)
  end

  test "delete_video/1 deletes the video" do
    video = fixture(:video)
    assert {:ok, %Video{}} = VideoContext.delete_video(video)
    assert_raise Ecto.NoResultsError, fn -> VideoContext.get_video!(video.id) end
  end

  test "change_video/1 returns a video changeset" do
    video = fixture(:video)
    assert %Ecto.Changeset{} = VideoContext.change_video(video)
  end
end
