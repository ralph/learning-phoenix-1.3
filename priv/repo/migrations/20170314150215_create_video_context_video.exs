defmodule Rumbl.Repo.Migrations.CreateRumbl.VideoContext.Video do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :url, :string
      add :title, :string
      add :description, :text
      add :user_id, references(:accounts_users, on_delete: :nothing)

      timestamps()
    end

    create index(:videos, [:user_id])
  end
end
