defmodule PapaWeb.GraphQL.Schema.Users.Mutations do
  @moduledoc """
  GraphQL mutations for Users
  """

  use Absinthe.Schema.Notation

  alias PapaWeb.GraphQL.Schema.Users.Resolvers

  object :user_mutations do
    @desc "Create a user"
    field :create_user, :user do
      @desc "first name of user"
      arg(:first_name, :string)
      @desc "last name of user"
      arg(:last_name, :string)
      @desc "email of user"
      arg(:email, :string)
      @desc "is a member"
      arg(:member, :boolean)
      @desc "is a pal"
      arg(:pal, :boolean)

      resolve(&Resolvers.create/3)
    end
  end
end
