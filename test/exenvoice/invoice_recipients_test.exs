defmodule Exinvoice.InvoiceRecipientsTest do
  use Exinvoice.DataCase

  alias Exinvoice.InvoiceRecipients

  describe "invoice_recipients" do
    alias Exinvoice.InvoiceRecipients.InvoiceRecipient

    import Exinvoice.InvoiceRecipientsFixtures

    @invalid_attrs %{zip: nil, salutation: nil, first_name: nil, last_name: nil, address_line_1: nil, address_line_2: nil, street: nil, city: nil, invoice_salutation: nil}

    test "list_invoice_recipients/0 returns all invoice_recipients" do
      invoice_recipient = invoice_recipient_fixture()
      assert InvoiceRecipients.list_invoice_recipients() == [invoice_recipient]
    end

    test "get_invoice_recipient!/1 returns the invoice_recipient with given id" do
      invoice_recipient = invoice_recipient_fixture()
      assert InvoiceRecipients.get_invoice_recipient!(invoice_recipient.id) == invoice_recipient
    end

    test "create_invoice_recipient/1 with valid data creates a invoice_recipient" do
      valid_attrs = %{zip: "some zip", salutation: "some salutation", first_name: "some first_name", last_name: "some last_name", address_line_1: "some address_line_1", address_line_2: "some address_line_2", street: "some street", city: "some city", invoice_salutation: "some invoice_salutation"}

      assert {:ok, %InvoiceRecipient{} = invoice_recipient} = InvoiceRecipients.create_invoice_recipient(valid_attrs)
      assert invoice_recipient.zip == "some zip"
      assert invoice_recipient.salutation == "some salutation"
      assert invoice_recipient.first_name == "some first_name"
      assert invoice_recipient.last_name == "some last_name"
      assert invoice_recipient.address_line_1 == "some address_line_1"
      assert invoice_recipient.address_line_2 == "some address_line_2"
      assert invoice_recipient.street == "some street"
      assert invoice_recipient.city == "some city"
      assert invoice_recipient.invoice_salutation == "some invoice_salutation"
    end

    test "create_invoice_recipient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = InvoiceRecipients.create_invoice_recipient(@invalid_attrs)
    end

    test "update_invoice_recipient/2 with valid data updates the invoice_recipient" do
      invoice_recipient = invoice_recipient_fixture()
      update_attrs = %{zip: "some updated zip", salutation: "some updated salutation", first_name: "some updated first_name", last_name: "some updated last_name", address_line_1: "some updated address_line_1", address_line_2: "some updated address_line_2", street: "some updated street", city: "some updated city", invoice_salutation: "some updated invoice_salutation"}

      assert {:ok, %InvoiceRecipient{} = invoice_recipient} = InvoiceRecipients.update_invoice_recipient(invoice_recipient, update_attrs)
      assert invoice_recipient.zip == "some updated zip"
      assert invoice_recipient.salutation == "some updated salutation"
      assert invoice_recipient.first_name == "some updated first_name"
      assert invoice_recipient.last_name == "some updated last_name"
      assert invoice_recipient.address_line_1 == "some updated address_line_1"
      assert invoice_recipient.address_line_2 == "some updated address_line_2"
      assert invoice_recipient.street == "some updated street"
      assert invoice_recipient.city == "some updated city"
      assert invoice_recipient.invoice_salutation == "some updated invoice_salutation"
    end

    test "update_invoice_recipient/2 with invalid data returns error changeset" do
      invoice_recipient = invoice_recipient_fixture()
      assert {:error, %Ecto.Changeset{}} = InvoiceRecipients.update_invoice_recipient(invoice_recipient, @invalid_attrs)
      assert invoice_recipient == InvoiceRecipients.get_invoice_recipient!(invoice_recipient.id)
    end

    test "delete_invoice_recipient/1 deletes the invoice_recipient" do
      invoice_recipient = invoice_recipient_fixture()
      assert {:ok, %InvoiceRecipient{}} = InvoiceRecipients.delete_invoice_recipient(invoice_recipient)
      assert_raise Ecto.NoResultsError, fn -> InvoiceRecipients.get_invoice_recipient!(invoice_recipient.id) end
    end

    test "change_invoice_recipient/1 returns a invoice_recipient changeset" do
      invoice_recipient = invoice_recipient_fixture()
      assert %Ecto.Changeset{} = InvoiceRecipients.change_invoice_recipient(invoice_recipient)
    end
  end
end
