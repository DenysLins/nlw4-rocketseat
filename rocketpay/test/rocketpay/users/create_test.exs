defmodule Rocketpay.CreateTest do
  use Rocketpay.DataCase
  alias Ecto.Changeset
  alias Rocketpay.Users.Create
  alias Rocketpay.Users
  alias Rocketpay.User

  describe "call/1" do
    test "When all params are valid, return an user" do
      params = %{
        name: "User",
        password: "123456",
        nickname: "User",
        email: "user@user.com",
        age: 30
      }
      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)
      assert %User{name: "User", age: 30, id: ^user_id} = user
    end

    test "When there are invalid params, return an error" do
      params = %{
        name: "User",
        nickname: "User",
        email: "user@user.com",
        age: 15
      }
      {:error, changeset} = Create.call(params)
      expected_result = %{age: ["must be greater than or equal to 18"], password: ["can't be blank"]}
      assert expected_result == errors_on(changeset)
    end
  end
end
