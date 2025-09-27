defmodule ExinvoiceWeb.InvoiceItemControllerTest do
  use ExinvoiceWeb.ConnCase

  import Exinvoice.InvoiceItemsFixtures

  @create_attrs %{no: 42, service_description: "some service_description", price_per_unit: 42, minutes_per_unit: 42, show_events: true}
  @update_attrs %{no: 43, service_description: "some updated service_description", price_per_unit: 43, minutes_per_unit: 43, show_events: false}
  @invalid_attrs %{no: nil, service_description: nil, price_per_unit: nil, minutes_per_unit: nil, show_events: nil}

  describe "index" do
    test "lists all invoice_items", %{conn: conn} do
      conn = get(conn, ~p"/invoice_items")
      assert html_response(conn, 200) =~ "Listing Invoice items"
    end
  end

  describe "new invoice_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/invoice_items/new")
      assert html_response(conn, 200) =~ "New Invoice item"
    end
  end

  describe "create invoice_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/invoice_items", invoice_item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/invoice_items/#{id}"

      conn = get(conn, ~p"/invoice_items/#{id}")
      assert html_response(conn, 200) =~ "Invoice item #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/invoice_items", invoice_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Invoice item"
    end
  end

  describe "edit invoice_item" do
    setup [:create_invoice_item]

    test "renders form for editing chosen invoice_item", %{conn: conn, invoice_item: invoice_item} do
      conn = get(conn, ~p"/invoice_items/#{invoice_item}/edit")
      assert html_response(conn, 200) =~ "Edit Invoice item"
    end
  end

  describe "update invoice_item" do
    setup [:create_invoice_item]

    test "redirects when data is valid", %{conn: conn, invoice_item: invoice_item} do
      conn = put(conn, ~p"/invoice_items/#{invoice_item}", invoice_item: @update_attrs)
      assert redirected_to(conn) == ~p"/invoice_items/#{invoice_item}"

      conn = get(conn, ~p"/invoice_items/#{invoice_item}")
      assert html_response(conn, 200) =~ "some updated service_description"
    end

    test "renders errors when data is invalid", %{conn: conn, invoice_item: invoice_item} do
      conn = put(conn, ~p"/invoice_items/#{invoice_item}", invoice_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Invoice item"
    end
  end

  describe "delete invoice_item" do
    setup [:create_invoice_item]

    test "deletes chosen invoice_item", %{conn: conn, invoice_item: invoice_item} do
      conn = delete(conn, ~p"/invoice_items/#{invoice_item}")
      assert redirected_to(conn) == ~p"/invoice_items"

      assert_error_sent 404, fn ->
        get(conn, ~p"/invoice_items/#{invoice_item}")
      end
    end
  end

  defp create_invoice_item(_) do
    invoice_item = invoice_item_fixture()

    %{invoice_item: invoice_item}
  end
end
