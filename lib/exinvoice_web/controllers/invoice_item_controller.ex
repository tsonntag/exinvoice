defmodule ExinvoiceWeb.InvoiceItemController do
  use ExinvoiceWeb, :controller

  alias Exinvoice.Invoices.InvoiceItem
  alias Exinvoice.InvoiceItems

  def index(conn, _params) do
    invoice_items = InvoiceItems.list()
    render(conn, :index, invoice_items: invoice_items)
  end

  def new(conn, _params) do
    changeset = InvoiceItems.change(%InvoiceItem{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invoice_item" => invoice_item_params}) do
    case InvoiceItems.create(invoice_item_params) do
      {:ok, invoice_item} ->
        conn
        |> put_flash(:info, "Invoice item created successfully.")
        |> redirect(to: ~p"/invoice_items/#{invoice_item}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_item = InvoiceItems.get_invoice_item!(id)
    render(conn, :show, invoice_item: invoice_item)
  end

  def edit(conn, %{"id" => id}) do
    invoice_item = InvoiceItems.get_invoice_item!(id)
    changeset = InvoiceItems.change(invoice_item)
    render(conn, :edit, invoice_item: invoice_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice_item" => invoice_item_params}) do
    invoice_item = InvoiceItems.get_invoice_item!(id)

    case InvoiceItems.update(invoice_item, invoice_item_params) do
      {:ok, invoice_item} ->
        conn
        |> put_flash(:info, "Invoice item updated successfully.")
        |> redirect(to: ~p"/invoice_items/#{invoice_item}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, invoice_item: invoice_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_item = InvoiceItems.get_invoice_item!(id)
    {:ok, _invoice_item} = InvoiceItems.delete(invoice_item)

    conn
    |> put_flash(:info, "Invoice item deleted successfully.")
    |> redirect(to: ~p"/invoice_items")
  end
end
