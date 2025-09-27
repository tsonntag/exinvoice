defmodule ExinvoiceWeb.InvoiceRecipientControllerTest do
  use ExinvoiceWeb.ConnCase

  import Exinvoice.InvoiceRecipientsFixtures

  @create_attrs %{zip: "some zip", salutation: "some salutation", first_name: "some first_name", last_name: "some last_name", address_line_1: "some address_line_1", address_line_2: "some address_line_2", street: "some street", city: "some city", invoice_salutation: "some invoice_salutation"}
  @update_attrs %{zip: "some updated zip", salutation: "some updated salutation", first_name: "some updated first_name", last_name: "some updated last_name", address_line_1: "some updated address_line_1", address_line_2: "some updated address_line_2", street: "some updated street", city: "some updated city", invoice_salutation: "some updated invoice_salutation"}
  @invalid_attrs %{zip: nil, salutation: nil, first_name: nil, last_name: nil, address_line_1: nil, address_line_2: nil, street: nil, city: nil, invoice_salutation: nil}

  describe "index" do
    test "lists all invoice_recipients", %{conn: conn} do
      conn = get(conn, ~p"/invoice_recipients")
      assert html_response(conn, 200) =~ "Listing Invoice recipients"
    end
  end

  describe "new invoice_recipient" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/invoice_recipients/new")
      assert html_response(conn, 200) =~ "New Invoice recipient"
    end
  end

  describe "create invoice_recipient" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/invoice_recipients", invoice_recipient: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/invoice_recipients/#{id}"

      conn = get(conn, ~p"/invoice_recipients/#{id}")
      assert html_response(conn, 200) =~ "Invoice recipient #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/invoice_recipients", invoice_recipient: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Invoice recipient"
    end
  end

  describe "edit invoice_recipient" do
    setup [:create_invoice_recipient]

    test "renders form for editing chosen invoice_recipient", %{conn: conn, invoice_recipient: invoice_recipient} do
      conn = get(conn, ~p"/invoice_recipients/#{invoice_recipient}/edit")
      assert html_response(conn, 200) =~ "Edit Invoice recipient"
    end
  end

  describe "update invoice_recipient" do
    setup [:create_invoice_recipient]

    test "redirects when data is valid", %{conn: conn, invoice_recipient: invoice_recipient} do
      conn = put(conn, ~p"/invoice_recipients/#{invoice_recipient}", invoice_recipient: @update_attrs)
      assert redirected_to(conn) == ~p"/invoice_recipients/#{invoice_recipient}"

      conn = get(conn, ~p"/invoice_recipients/#{invoice_recipient}")
      assert html_response(conn, 200) =~ "some updated salutation"
    end

    test "renders errors when data is invalid", %{conn: conn, invoice_recipient: invoice_recipient} do
      conn = put(conn, ~p"/invoice_recipients/#{invoice_recipient}", invoice_recipient: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Invoice recipient"
    end
  end

  describe "delete invoice_recipient" do
    setup [:create_invoice_recipient]

    test "deletes chosen invoice_recipient", %{conn: conn, invoice_recipient: invoice_recipient} do
      conn = delete(conn, ~p"/invoice_recipients/#{invoice_recipient}")
      assert redirected_to(conn) == ~p"/invoice_recipients"

      assert_error_sent 404, fn ->
        get(conn, ~p"/invoice_recipients/#{invoice_recipient}")
      end
    end
  end

  defp create_invoice_recipient(_) do
    invoice_recipient = invoice_recipient_fixture()

    %{invoice_recipient: invoice_recipient}
  end
end
