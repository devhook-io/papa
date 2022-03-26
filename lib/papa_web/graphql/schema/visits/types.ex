defmodule PapaWeb.GraphQL.Schema.Visits.Types do
  use Absinthe.Schema.Notation

  import_types(Absinthe.Type.Custom)
  import_types(PapaWeb.GraphQL.Schema.Visits.Mutations)
  import_types(PapaWeb.GraphQL.Schema.Visits.Queries)

  @desc "A visit"
  object :visit do
    @desc "Visit minutes"
    field(:minutes, :float)
    @desc "Visit tasks"
    field(:tasks, list_of(:string))
    @desc "Visit date"
    field(:date, :datetime)
    @desc "Visit member"
    field(:member, :user)
    @desc "Visit id"
    field(:id, :id)
  end

  @desc "A transaction"
  object :transaction do
    @desc "visit id"
    field(:visit_id, :id)
    @desc "member id"
    field(:member_id, :id)
    @desc "pal id"
    field(:pal_id, :id)
    @desc "transaction id"
    field(:id, :id)
  end
end
