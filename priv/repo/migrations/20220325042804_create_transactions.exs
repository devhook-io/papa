defmodule Papa.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :member_id, references(:users, on_delete: :nothing)
      add :pal_id, references(:users, on_delete: :nothing)
      add :visit_id, references(:visits, on_delete: :nothing)

      timestamps()
    end

    create index(:transactions, [:member_id])
    create index(:transactions, [:pal_id])
    create index(:transactions, [:visit_id])
  end
end
