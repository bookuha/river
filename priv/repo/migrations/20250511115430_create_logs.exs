defmodule River.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :owner, :string
      add :body, :map
      add :timestamp, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
