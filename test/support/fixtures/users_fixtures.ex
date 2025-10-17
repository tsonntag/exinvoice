defmodule Exinvoice.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exinvoice.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> Exinvoice.Users.create_user()

    user
  end
end
