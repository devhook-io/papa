defmodule PapaWeb.GraphQL.Schema.Types do
  use Absinthe.Schema.Notation

  import_types(PapaWeb.GraphQL.Schema.Users.Types)
  import_types(PapaWeb.GraphQL.Schema.Visits.Types)
end
