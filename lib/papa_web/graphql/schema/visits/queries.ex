defmodule PapaWeb.GraphQL.Schema.Visits.Queries do
  @moduledoc """
  GraphQL queries for Visits
  """

  use Absinthe.Schema.Notation

  alias PapaWeb.GraphQL.Schema.Visits.Resolvers

  object :visit_queries do
    @desc "Get a visit"
    field :get_visit, :visit do
      @desc "Visit ID"
      arg(:id, :id)

      resolve(&Resolvers.get/3)
    end
  end
end
