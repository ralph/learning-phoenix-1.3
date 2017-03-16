defmodule Rumbl.Repo.Migrations.RecreateUniqueUsernameIndex do
  use Ecto.Migration

  def change do
    drop index(:users, [:username])
    create unique_index(:accounts_users, [:username])
  end
end
