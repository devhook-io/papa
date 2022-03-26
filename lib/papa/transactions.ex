defmodule Papa.Transactions do
  alias Papa.Repo
  alias Papa.Transaction
  alias Papa.Users

  def create(params, visit) do
    transaction =
      %{
        member_id: visit.member_id,
        pal_id: params.pal_id,
        visit_id: visit.id
      }
      |> Transaction.changeset()

    Users.transfer_credits(visit.member_id, params.pal_id, visit.minutes)
    |> Ecto.Multi.insert(:transaction, transaction)
    |> Repo.transaction()
    |> case do
      {:ok, %{transaction: transaction}} ->
        {:ok, transaction}

      {:error, _, value, _} ->
        {:error, "Error from #{value} when creating transaction"}
    end
  end
end
