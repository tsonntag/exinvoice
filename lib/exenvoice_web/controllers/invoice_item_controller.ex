defmodule ExenvoiceWeb.InvoiceItemController do
  use ExenvoiceWeb, :controller

  alias Exenvoice.InvoiceItems
  alias Exenvoice.InvoiceItems.InvoiceItem

  def index(conn, _params) do
    invoice_items = InvoiceItems.list_invoice_items()
    render(conn, :index, invoice_items: invoice_items)
  end

  def new(conn, _params) do
    changeset = InvoiceItems.change_invoice_item(%InvoiceItem{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invoice_item" => invoice_item_params}) do
    case InvoiceItems.create_invoice_item(invoice_item_params) do
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
    changeset = InvoiceItems.change_invoice_item(invoice_item)
    render(conn, :edit, invoice_item: invoice_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice_item" => invoice_item_params}) do
    invoice_item = InvoiceItems.get_invoice_item!(id)

    case InvoiceItems.update_invoice_item(invoice_item, invoice_item_params) do
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
    {:ok, _invoice_item} = InvoiceItems.delete_invoice_item(invoice_item)

    conn
    |> put_flash(:info, "Invoice item deleted successfully.")
    |> redirect(to: ~p"/invoice_items")
  end
end
