defmodule PapaWeb.GraphQL.Schema.Users.Queries do
  @moduledoc """
  GraphQL queries for Users
  """

  use Absinthe.Schema.Notation

  alias PapaWeb.GraphQL.Schema.Users.Resolvers

  object :user_queries do
    @desc "Get a user"
    field :get_user, :user do
      @desc "User ID"
      arg(:id, :id)

      resolve(&Resolvers.get/3)
    end
  end
end
