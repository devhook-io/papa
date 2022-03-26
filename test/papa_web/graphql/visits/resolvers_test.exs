defmodule PapaWeb.GraphQL.Visits.ResolversTest do
  use PapaWeb.ConnCase

  alias Papa.Users
  alias Papa.Visits
  alias PapaWeb.GraphQL.Schema.Visits.Resolvers

  setup do
    {:ok, user} =
      Users.create(%{
        first_name: "Test",
        last_name: "McTesterson",
        email: "test@test.com",
        member: true,
        pal: true
      })

    params = %{
      minutes: 20,
      date: "2022-03-25T00:00:00Z",
      member_id: user.id,
      tasks: [
        "Take out the trash"
      ]
    }

    [params: params, user: user]
  end

  describe "create/3" do
    test "Successfully creates a new visit", %{params: params} do
      {:ok, visit} = Resolvers.create(nil, params, nil)
      assert Visits.get(visit.id)
    end

    test "Fails to create a visit when user doesn't have permission", %{params: params} do
      {:ok, member} =
        Users.create(%{
          first_name: "Test",
          last_name: "McTesterson",
          email: "test@test1.com",
          member: false,
          pal: true
        })

      params = Map.put(params, :member_id, member.id)
      Resolvers.create(nil, params, nil)

      assert {:error, "You are not eligible to request a visit."} =
               Resolvers.create(nil, params, nil)
    end

    test "Fails to create a visit when user doesn't have enough credits", %{params: params} do
      {:ok, member} =
        Users.create(%{
          first_name: "Test",
          last_name: "McTesterson",
          email: "test@test1.com",
          member: true,
          pal: true,
          credits: 0
        })

      params = Map.put(params, :member_id, member.id)
      Resolvers.create(nil, params, nil)

      assert {:error, "You are not eligible to request a visit."} =
               Resolvers.create(nil, params, nil)
    end
  end

  describe "fulfill/3" do
    test "Successfully fulfills a visit", %{params: params} do
      {:ok, pal} =
        Users.create(%{
          first_name: "Test",
          last_name: "McTesterson",
          email: "test@test1.com",
          member: true,
          pal: true
        })

      {:ok, visit} = Visits.create(params)
      {:ok, transaction} = Resolvers.fulfill(nil, %{visit_id: visit.id, pal_id: pal.id}, nil)

      assert transaction.pal_id === pal.id
    end

    test "Does not fulfill a visit if fulfiller is not a pal", %{params: params} do
      {:ok, pal} =
        Users.create(%{
          first_name: "Test",
          last_name: "McTesterson",
          email: "test@test1.com",
          member: true,
          pal: false
        })

      {:ok, visit} = Visits.create(params)

      assert {:error, "You are not eligible to fulfill a visit."} =
               Resolvers.fulfill(nil, %{visit_id: visit.id, pal_id: pal.id}, nil)
    end
  end

  describe "get/3" do
    test "Successfully gets an existing visit", %{params: params} do
      {:ok, visit} = Visits.create(params)
      {:ok, result} = Resolvers.get(nil, %{id: visit.id}, nil)

      assert visit.date == result.date
    end

    test "Returns an error when retrieving a visit that does not exist" do
      assert {:error, "Visit not found"} = Resolvers.get(nil, %{id: 1}, nil)
    end
  end
end
