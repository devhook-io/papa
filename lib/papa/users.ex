defmodule Papa.Users do
  import Ecto.Query

  alias Papa.Repo
  alias Papa.User

  def create(params), do: params |> User.changeset() |> Repo.insert()

  def get(id), do: Repo.get(User, id)

  def can_fulfill_visit?(id) do
    query =
      User
      |> where([u], u.pal == true)

    case Repo.get(query, id) do
      %User{} -> true
      nil -> false
    end
  end

  def can_request_visit?(id, minutes) do
    query =
      User
      |> where([u], u.member == true and u.credits > ^minutes)

    case Repo.get(query, id) do
      %User{} -> true
      nil -> false
    end
  end

  def transfer_credits(member_id, pal_id, visit_minutes) do
    pal_credits = visit_minutes * 0.85
    visit_minutes = -visit_minutes

    member_update =
      from User,
        where: [id: ^member_id],
        update: [inc: [credits: ^visit_minutes]]

    pal_update =
      from User,
        where: [id: ^pal_id],
        update: [inc: [credits: ^pal_credits]]

    Ecto.Multi.new()
    |> Ecto.Multi.update_all(:member, member_update, [])
    |> Ecto.Multi.update_all(:pal, pal_update, [])
  end
end
