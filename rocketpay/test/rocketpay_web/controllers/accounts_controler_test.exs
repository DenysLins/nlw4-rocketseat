defmodule Rocketpay.AccountsControllerTest do
  use RocketpayWeb.ConnCase

  alias Rocketpay.{Account, User}

  describe "deposit/2" do

    setup %{conn: conn} do
      params = %{
        name: "User",
        password: "123456",
        nickname: "User",
        email: "user@user.com",
        age: 30
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user((params))

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "When all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.0"}

      response = conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{"account" => %{"balance" => "50.00", "id" => _id}, "message" => "Balance changed succesfully"} = response
    end

    test "When there are invalid params, return an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response = conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert %{"message" => "Invalid deposit value!"} = response
    end
  end
end
