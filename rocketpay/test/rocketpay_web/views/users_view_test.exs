defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView
  alias Rocketpay.Users.Create

  test "renders create.json" do
    params = %{
      name: "User",
      password: "123456",
      nickname: "User",
      email: "user@user.com",
      age: 30
    }
    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Create.call(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "User",
        nickname: "User"
      }
    }

    assert expected_response == response


  end
end
