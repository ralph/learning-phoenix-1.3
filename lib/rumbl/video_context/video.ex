defmodule Rumbl.VideoContext.Video do
  use Ecto.Schema

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Rumbl.Accounts.User
    belongs_to :category, Rumbl.VideoContext.Category

    timestamps()
  end
end
