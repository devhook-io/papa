defmodule PapaWeb.GraphQL.Schema.Visits.Resolvers do
  alias Papa.Transactions
  alias Papa.Users
  alias Papa.Visit
  alias Papa.Visits

  def create(_, params, _) do
    with true <- Users.can_request_visit?(params.member_id, params.minutes),
         {:ok, visit} <- Visits.create(params) do
      {:ok, visit}
    else
      false -> {:error, "You are not eligible to request a visit."}
      error -> IO.inspect(error)
    end
  end

  def fulfill(_, params, _) do
    with true <- Users.can_fulfill_visit?(params.pal_id),
         %Visit{} = visit <- Visits.get(params.visit_id),
         true <- params.pal_id != visit.member_id,
         {:ok, transaction} <- Transactions.create(params, visit) do
      {:ok, transaction}
    else
      false -> {:error, "You are not eligible to fulfill a visit."}
      error -> IO.inspect(error)
    end
  end

  def get(_, %{id: id}, _) do
    case Visits.get(id) do
      %Visit{} = visit -> {:ok, visit}
      nil -> {:error, "Visit not found"}
    end
  end
end
