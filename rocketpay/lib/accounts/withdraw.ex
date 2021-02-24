defmodule Rocketpay.Accounts.Withdraw do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}

  def call(%{"id" => id, "value" => value}) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> read_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} -> update_balance(repo, account, value) end)
    |> run_transaction()
  end

  defp read_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sub_values(value)
    |> update_account(repo, account)
  end

  defp sub_values(%Account{balance: balance}, value) do
    value
    |> Decimal.cast()
    |> handle_cast(balance)
  end

  defp handle_cast({:ok, value}, balance), do: Decimal.sub(balance, value)
  defp handle_cast(:error, _balance), do: {:error, "Invalid deposit value!"}

  defp update_account(_account, _repo, {:error, _value} = error), do: error
  defp update_account(value, repo, account) do
    params = %{balance: value}
    account
    |> Account.changeset(params)
    |> repo.update()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{update_balance: account}} -> {:ok, account}
    end
  end

end
