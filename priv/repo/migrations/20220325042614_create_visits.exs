defmodule Papa.Repo.Migrations.CreateVisits do
  use Ecto.Migration

  def change do
    create table(:visits) do
      add :date, :utc_datetime
      add :minutes, :float
      add :tasks, {:array, :string}
      add :member_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:visits, [:member_id])
  end
end
