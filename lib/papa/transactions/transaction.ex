defmodule Papa.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias Papa.User
  alias Papa.Visit

  schema "transactions" do
    belongs_to :member, User
    belongs_to :pal, User
    belongs_to :visit, Visit

    timestamps()
  end

  @doc false
  def changeset(transaction \\ %__MODULE__{}, attrs) do
    transaction
    |> cast(attrs, [:member_id, :pal_id, :visit_id])
    |> validate_required([:member_id, :pal_id, :visit_id])
    |> assoc_constraint(:member)
    |> assoc_constraint(:pal)
    |> assoc_constraint(:visit)
  end
end
