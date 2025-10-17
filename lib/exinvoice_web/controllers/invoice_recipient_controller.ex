defmodule ExinvoiceWeb.InvoiceRecipientController do
  use ExinvoiceWeb, :controller

  alias Exinvoice.InvoiceRecipients
  alias Exinvoice.InvoiceRecipients.InvoiceRecipient

  def index(conn, _params) do
    invoice_recipients = InvoiceRecipients.list()
    render(conn, :index, invoice_recipients: invoice_recipients)
  end

  def new(conn, _params) do
    changeset = InvoiceRecipients.change(%InvoiceRecipient{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invoice_recipient" => invoice_recipient_params}) do
    case InvoiceRecipients.create(invoice_recipient_params) do
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
    changeset = InvoiceRecipients.change(invoice_recipient)
    render(conn, :edit, invoice_recipient: invoice_recipient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice_recipient" => invoice_recipient_params}) do
    invoice_recipient = InvoiceRecipients.get_invoice_recipient!(id)

    case InvoiceRecipients.update(invoice_recipient, invoice_recipient_params) do
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
    {:ok, _invoice_recipient} = InvoiceRecipients.delete(invoice_recipient)

    conn
    |> put_flash(:info, "Invoice recipient deleted successfully.")
    |> redirect(to: ~p"/invoice_recipients")
  end
end
