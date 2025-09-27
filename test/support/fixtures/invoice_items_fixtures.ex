defmodule Exinvoice.InvoiceItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exinvoice.InvoiceItems` context.
  """

  @doc """
  Generate a invoice_item.
  """
  def invoice_item_fixture(attrs \\ %{}) do
    {:ok, invoice_item} =
      attrs
      |> Enum.into(%{
        minutes_per_unit: 42,
        no: 42,
        price_per_unit: 42,
        service_description: "some service_description",
        show_events: true
      })
      |> Exinvoice.InvoiceItems.create_invoice_item()

    invoice_item
  end
end
