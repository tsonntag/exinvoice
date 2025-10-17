defmodule ExinvoiceWeb.InvoiceController do
  use ExinvoiceWeb, :controller

  alias Exinvoice.Invoices
  alias Exinvoice.Invoices.Invoice

  def index(conn, _params) do
    invoices = Invoices.list()
    render(conn, :index, invoices: invoices)
  end

  def new(conn, _params) do
    changeset = Invoices.change(%Invoice{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invoice" => invoice_params}) do
    case Invoices.create(invoice_params) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice created successfully.")
        |> redirect(to: ~p"/invoices/#{invoice}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice = Invoices.get_event!(id)
    render(conn, :show, invoice: invoice)
  end

  def edit(conn, %{"id" => id}) do
    invoice = Invoices.get_event!(id)
    changeset = Invoices.change(invoice)
    render(conn, :edit, invoice: invoice, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice" => invoice_params}) do
    invoice = Invoices.get_event!(id)

    case Invoices.update(invoice, invoice_params) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice updated successfully.")
        |> redirect(to: ~p"/invoices/#{invoice}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, invoice: invoice, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice = Invoices.get_event!(id)
    {:ok, _invoice} = Invoices.delete(invoice)

    conn
    |> put_flash(:info, "Invoice deleted successfully.")
    |> redirect(to: ~p"/invoices")
  end
end
