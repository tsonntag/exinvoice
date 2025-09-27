defmodule Exinvoice.InvoiceRecipientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exinvoice.InvoiceRecipients` context.
  """

  @doc """
  Generate a invoice_recipient.
  """
  def invoice_recipient_fixture(attrs \\ %{}) do
    {:ok, invoice_recipient} =
      attrs
      |> Enum.into(%{
        address_line_1: "some address_line_1",
        address_line_2: "some address_line_2",
        city: "some city",
        first_name: "some first_name",
        invoice_salutation: "some invoice_salutation",
        last_name: "some last_name",
        salutation: "some salutation",
        street: "some street",
        zip: "some zip"
      })
      |> Exinvoice.InvoiceRecipients.create_invoice_recipient()

    invoice_recipient
  end
end
