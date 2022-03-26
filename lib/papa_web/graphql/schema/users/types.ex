defmodule PapaWeb.GraphQL.Schema.Users.Types do
  use Absinthe.Schema.Notation

  import_types(PapaWeb.GraphQL.Schema.Users.Mutations)
  import_types(PapaWeb.GraphQL.Schema.Users.Queries)

  @desc "A user"
  object :user do
    @desc "User first name"
    field(:first_name, :string)
    @desc "User last name"
    field(:last_name, :string)
    @desc "User email"
    field(:email, :string)
    @desc "User credits"
    field(:credits, :float)
    @desc "If the user is a member"
    field(:member, :boolean)
    @desc "If the user is a pal"
    field(:pal, :boolean)
    @desc "User ID"
    field(:id, :id)
  end
end
