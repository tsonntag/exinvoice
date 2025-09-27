defmodule Exinvoice.InvoicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exinvoice.Invoices` context.
  """

  @doc """
  Generate a invoice.
  """
  def invoice_fixture(attrs \\ %{}) do
    {:ok, invoice} =
      attrs
      |> Enum.into(%{
        date: ~D[2025-09-26],
        diagnosis: "some diagnosis",
        no: "some no",
        sum_events: true,
        year_month: ~D[2025-09-26]
      })
      |> Exinvoice.Invoices.create_invoice()

    invoice
  end
end
