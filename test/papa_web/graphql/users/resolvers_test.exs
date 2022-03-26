defmodule PapaWeb.GraphQL.Users.ResolversTest do
  use PapaWeb.ConnCase

  alias Papa.Users
  alias PapaWeb.GraphQL.Schema.Users.Resolvers

  setup do
    params = %{
      first_name: "Test",
      last_name: "McTesterson",
      email: "test@test.com",
      member: true,
      pal: true
    }

    [params: params]
  end

  describe "create/3" do
    test "Successfully creates a new user", %{params: params} do
      {:ok, user} = Resolvers.create(nil, params, nil)
      assert Users.get(user.id)
    end

    test "Does not create a user with the same email", %{params: params} do
      Resolvers.create(nil, params, nil)
      assert {:error, "Unable to create user"} = Resolvers.create(nil, params, nil)
    end
  end

  describe "get/3" do
    test "Successfully gets an existing user", %{params: params} do
      {:ok, user} = Users.create(params)
      {:ok, result} = Resolvers.get(nil, %{id: user.id}, nil)

      assert user.first_name == result.first_name
    end

    test "Returns an error when retrieving a user that does not exist" do
      assert {:error, "User not found"} = Resolvers.get(nil, %{id: 1}, nil)
    end
  end
end
