defmodule Papa.Visit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Papa.User

  schema "visits" do
    field :date, :utc_datetime
    field :minutes, :float
    field :tasks, {:array, :string}
    belongs_to :member, User

    timestamps()
  end

  @doc false
  def changeset(visit \\ %__MODULE__{}, attrs) do
    visit
    |> cast(attrs, [:date, :minutes, :tasks, :member_id])
    |> validate_required([:date, :minutes, :tasks, :member_id])
    |> assoc_constraint(:member)
  end
end
