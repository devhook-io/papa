defmodule PapaWeb.GraphQL.Schema.Visits.Mutations do
  @moduledoc """
  GraphQL mutations for Visits
  """

  use Absinthe.Schema.Notation

  alias PapaWeb.GraphQL.Schema.Visits.Resolvers

  object :visit_mutations do
    @desc "Create a visit"
    field :create_visit, :visit do
      @desc "tasks of visit"
      arg(:tasks, list_of(:string))
      @desc "date of visit"
      arg(:date, :datetime)
      @desc "member id of visit"
      arg(:member_id, :id)
      @desc "minutes of visit"
      arg(:minutes, :float)

      resolve(&Resolvers.create/3)
    end

    @desc "fulfill a visit"
    field :fulfill_visit, :transaction do
      @desc "visit id"
      arg(:visit_id, :id)
      @desc "date of visit"
      arg(:pal_id, :id)

      resolve(&Resolvers.fulfill/3)
    end
  end
end
