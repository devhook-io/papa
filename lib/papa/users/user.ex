defmodule Papa.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :credits, :float, default: 100.0
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :member, :boolean, default: false
    field :pal, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(struct \\ %__MODULE__{}, attrs) do
    struct
    |> cast(attrs, [:first_name, :last_name, :credits, :member, :pal, :email])
    |> validate_required([
      :first_name,
      :last_name,
      :credits,
      :member,
      :pal,
      :email
    ])
    |> unique_constraint(:email)
  end
end
