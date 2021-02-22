defmodule Rocketpay.NumbersTest do

  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do

    test "When there is a file with valid name, returns the sum of numbers" do
      response = Numbers.sum_from_file("numbers")
      expected_response = {:ok, %{result: 37}}
      assert response == expected_response
    end

    test "When there is a file with invalid name, returns error message" do
      response = Numbers.sum_from_file("banana")
      expected_response = {:error, "Invalid name"}
      assert response == expected_response
    end

  end

end
