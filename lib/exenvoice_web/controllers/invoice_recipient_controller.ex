defmodule ExenvoiceWeb.InvoiceRecipientController do
  use ExenvoiceWeb, :controller

  alias Exenvoice.InvoiceRecipients
  alias Exenvoice.InvoiceRecipients.InvoiceRecipient

  def index(conn, _params) do
    invoice_recipients = InvoiceRecipients.list_invoice_recipients()
    render(conn, :index, invoice_recipients: invoice_recipients)
  end

  def new(conn, _params) do
    changeset = InvoiceRecipients.change_invoice_recipient(%InvoiceRecipient{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invoice_recipient" => invoice_recipient_params}) do
    case InvoiceRecipients.create_invoice_recipient(invoice_recipient_params) do
      {:ok, invoice_recipient} ->
        conn
        |> put_flash(:info, "Invoice recipient created successfully.")
        |> redirect(to: ~p"/invoice_recipients/#{invoice_recipient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_recipient = InvoiceRecipients.get_invoice_recipient!(id)
    render(conn, :show, invoice_recipient: invoice_recipient)
  end

  def edit(conn, %{"id" => id}) do
    invoice_recipient = InvoiceRecipients.get_invoice_recipient!(id)
    changeset = InvoiceRecipients.change_invoice_recipient(invoice_recipient)
    render(conn, :edit, invoice_recipient: invoice_recipient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice_recipient" => invoice_recipient_params}) do
    invoice_recipient = InvoiceRecipients.get_invoice_recipient!(id)

    case InvoiceRecipients.update_invoice_recipient(invoice_recipient, invoice_recipient_params) do
      {:ok, invoice_recipient} ->
        conn
        |> put_flash(:info, "Invoice recipient updated successfully.")
        |> redirect(to: ~p"/invoice_recipients/#{invoice_recipient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, invoice_recipient: invoice_recipient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_recipient = InvoiceRecipients.get_invoice_recipient!(id)
    {:ok, _invoice_recipient} = InvoiceRecipients.delete_invoice_recipient(invoice_recipient)

    conn
    |> put_flash(:info, "Invoice recipient deleted successfully.")
    |> redirect(to: ~p"/invoice_recipients")
  end
end
