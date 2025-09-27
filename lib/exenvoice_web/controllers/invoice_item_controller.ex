defmodule ExenvoiceWeb.InvoiceItemController do
  use ExenvoiceWeb, :controller

  alias Exenvoice.InvoiceItem

  def index(conn, _params) do
    invoice_items = InvoiceItem.list()
    render(conn, :index, invoice_items: invoice_items)
  end

  def new(conn, _params) do
    changeset = InvoiceItem.change(%InvoiceItem{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invoice_item" => invoice_item_params}) do
    case InvoiceItem.create(invoice_item_params) do
      {:ok, invoice_item} ->
        conn
        |> put_flash(:info, "Invoice item created successfully.")
        |> redirect(to: ~p"/invoice_items/#{invoice_item}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_item = InvoiceItem.get!(id)
    render(conn, :show, invoice_item: invoice_item)
  end

  def edit(conn, %{"id" => id}) do
    invoice_item = InvoiceItem.get!(id)
    changeset = InvoiceItem.change(invoice_item)
    render(conn, :edit, invoice_item: invoice_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice_item" => invoice_item_params}) do
    invoice_item = InvoiceItem.get!(id)

    case InvoiceItem.update(invoice_item, invoice_item_params) do
      {:ok, invoice_item} ->
        conn
        |> put_flash(:info, "Invoice item updated successfully.")
        |> redirect(to: ~p"/invoice_items/#{invoice_item}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, invoice_item: invoice_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_item = InvoiceItem.get!(id)
    {:ok, _invoice_item} = InvoiceItem.delete(invoice_item)

    conn
    |> put_flash(:info, "Invoice item deleted successfully.")
    |> redirect(to: ~p"/invoice_items")
  end
end
