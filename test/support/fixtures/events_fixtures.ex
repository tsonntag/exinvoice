defmodule Exenvoice.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exenvoice.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        from_datetime: ~U[2025-09-26 12:20:00Z],
        summary: "some summary",
        to_datetime: ~U[2025-09-26 12:20:00Z]
      })
      |> Exenvoice.Events.create_event()

    event
  end
end
