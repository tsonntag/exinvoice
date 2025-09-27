defmodule Exinvoice.InvoiceItemsTest do
  use Exinvoice.DataCase

  alias Exinvoice.InvoiceItems

  describe "invoice_items" do
    alias Exinvoice.InvoiceItems.InvoiceItem

    import Exinvoice.InvoiceItemsFixtures

    @invalid_attrs %{no: nil, service_description: nil, price_per_unit: nil, minutes_per_unit: nil, show_events: nil}

    test "list_invoice_items/0 returns all invoice_items" do
      invoice_item = invoice_item_fixture()
      assert InvoiceItems.list_invoice_items() == [invoice_item]
    end

    test "get_invoice_item!/1 returns the invoice_item with given id" do
      invoice_item = invoice_item_fixture()
      assert InvoiceItems.get_invoice_item!(invoice_item.id) == invoice_item
    end

    test "create_invoice_item/1 with valid data creates a invoice_item" do
      valid_attrs = %{no: 42, service_description: "some service_description", price_per_unit: 42, minutes_per_unit: 42, show_events: true}

      assert {:ok, %InvoiceItem{} = invoice_item} = InvoiceItems.create_invoice_item(valid_attrs)
      assert invoice_item.no == 42
      assert invoice_item.service_description == "some service_description"
      assert invoice_item.price_per_unit == 42
      assert invoice_item.minutes_per_unit == 42
      assert invoice_item.show_events == true
    end

    test "create_invoice_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = InvoiceItems.create_invoice_item(@invalid_attrs)
    end

    test "update_invoice_item/2 with valid data updates the invoice_item" do
      invoice_item = invoice_item_fixture()
      update_attrs = %{no: 43, service_description: "some updated service_description", price_per_unit: 43, minutes_per_unit: 43, show_events: false}

      assert {:ok, %InvoiceItem{} = invoice_item} = InvoiceItems.update_invoice_item(invoice_item, update_attrs)
      assert invoice_item.no == 43
      assert invoice_item.service_description == "some updated service_description"
      assert invoice_item.price_per_unit == 43
      assert invoice_item.minutes_per_unit == 43
      assert invoice_item.show_events == false
    end

    test "update_invoice_item/2 with invalid data returns error changeset" do
      invoice_item = invoice_item_fixture()
      assert {:error, %Ecto.Changeset{}} = InvoiceItems.update_invoice_item(invoice_item, @invalid_attrs)
      assert invoice_item == InvoiceItems.get_invoice_item!(invoice_item.id)
    end

    test "delete_invoice_item/1 deletes the invoice_item" do
      invoice_item = invoice_item_fixture()
      assert {:ok, %InvoiceItem{}} = InvoiceItems.delete_invoice_item(invoice_item)
      assert_raise Ecto.NoResultsError, fn -> InvoiceItems.get_invoice_item!(invoice_item.id) end
    end

    test "change_invoice_item/1 returns a invoice_item changeset" do
      invoice_item = invoice_item_fixture()
      assert %Ecto.Changeset{} = InvoiceItems.change_invoice_item(invoice_item)
    end
  end
end
