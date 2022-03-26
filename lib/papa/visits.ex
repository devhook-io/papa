defmodule Papa.Visits do
  alias Papa.Repo
  alias Papa.Visit

  def create(params),
    do: params |> Visit.changeset() |> Repo.insert()

  @spec get(any) :: nil | [%{optional(atom) => any}] | %{optional(atom) => any}
  def get(id), do: Repo.get(Visit, id) |> Repo.preload(:member)
end
