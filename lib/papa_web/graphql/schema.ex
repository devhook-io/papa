defmodule PapaWeb.Schema do
  use Absinthe.Schema

  import_types(PapaWeb.GraphQL.Schema.Types)

  query do
    import_fields(:user_queries)
    import_fields(:visit_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:visit_mutations)
  end
end
