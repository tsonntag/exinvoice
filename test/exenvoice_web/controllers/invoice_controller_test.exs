defmodule ExinvoiceWeb.InvoiceControllerTest do
  use ExinvoiceWeb.ConnCase

  import Exinvoice.InvoicesFixtures

  @create_attrs %{no: "some no", date: ~D[2025-09-26], year_month: ~D[2025-09-26], diagnosis: "some diagnosis", sum_events: true}
  @update_attrs %{no: "some updated no", date: ~D[2025-09-27], year_month: ~D[2025-09-27], diagnosis: "some updated diagnosis", sum_events: false}
  @invalid_attrs %{no: nil, date: nil, year_month: nil, diagnosis: nil, sum_events: nil}

  describe "index" do
    test "lists all invoices", %{conn: conn} do
      conn = get(conn, ~p"/invoices")
      assert html_response(conn, 200) =~ "Listing Invoices"
    end
  end

  describe "new invoice" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/invoices/new")
      assert html_response(conn, 200) =~ "New Invoice"
    end
  end

  describe "create invoice" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/invoices", invoice: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/invoices/#{id}"

      conn = get(conn, ~p"/invoices/#{id}")
      assert html_response(conn, 200) =~ "Invoice #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/invoices", invoice: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Invoice"
    end
  end

  describe "edit invoice" do
    setup [:create_invoice]

    test "renders form for editing chosen invoice", %{conn: conn, invoice: invoice} do
      conn = get(conn, ~p"/invoices/#{invoice}/edit")
      assert html_response(conn, 200) =~ "Edit Invoice"
    end
  end

  describe "update invoice" do
    setup [:create_invoice]

    test "redirects when data is valid", %{conn: conn, invoice: invoice} do
      conn = put(conn, ~p"/invoices/#{invoice}", invoice: @update_attrs)
      assert redirected_to(conn) == ~p"/invoices/#{invoice}"

      conn = get(conn, ~p"/invoices/#{invoice}")
      assert html_response(conn, 200) =~ "some updated no"
    end

    test "renders errors when data is invalid", %{conn: conn, invoice: invoice} do
      conn = put(conn, ~p"/invoices/#{invoice}", invoice: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Invoice"
    end
  end

  describe "delete invoice" do
    setup [:create_invoice]

    test "deletes chosen invoice", %{conn: conn, invoice: invoice} do
      conn = delete(conn, ~p"/invoices/#{invoice}")
      assert redirected_to(conn) == ~p"/invoices"

      assert_error_sent 404, fn ->
        get(conn, ~p"/invoices/#{invoice}")
      end
    end
  end

  defp create_invoice(_) do
    invoice = invoice_fixture()

    %{invoice: invoice}
  end
end
