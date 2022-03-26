defmodule PapaWeb.GraphQL.Schema.Users.Resolvers do
  alias Papa.User
  alias Papa.Users

  def create(_, params, _) do
    case Users.create(params) do
      {:ok, user} -> {:ok, user}
      {:error, _} -> {:error, "Unable to create user"}
    end
  end

  @spec get(any, %{:id => any, optional(any) => any}, any) :: any
  def get(_, %{id: id}, _) do
    case Users.get(id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, "User not found"}
    end
  end
end
