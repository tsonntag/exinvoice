defmodule ExinvoiceWeb.InvoiceRecipientController do
  use ExinvoiceWeb, :controller

  alias Exinvoice.InvoiceRecipient

  def index(conn, _params) do
    invoice_recipients = InvoiceRecipient.list()
    render(conn, :index, invoice_recipients: invoice_recipients)
  end

  def new(conn, _params) do
    changeset = InvoiceRecipient.change(%InvoiceRecipient{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"invoice_recipient" => invoice_recipient_params}) do
    case InvoiceRecipient.create(invoice_recipient_params) do
      {:ok, invoice_recipient} ->
        conn
        |> put_flash(:info, "Invoice recipient created successfully.")
        |> redirect(to: ~p"/invoice_recipients/#{invoice_recipient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_recipient = InvoiceRecipient.get!(id)
    render(conn, :show, invoice_recipient: invoice_recipient)
  end

  def edit(conn, %{"id" => id}) do
    invoice_recipient = InvoiceRecipient.get!(id)
    changeset = InvoiceRecipient.change(invoice_recipient)
    render(conn, :edit, invoice_recipient: invoice_recipient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice_recipient" => invoice_recipient_params}) do
    invoice_recipient = InvoiceRecipient.get!(id)

    case InvoiceRecipient.update(invoice_recipient, invoice_recipient_params) do
      {:ok, invoice_recipient} ->
        conn
        |> put_flash(:info, "Invoice recipient updated successfully.")
        |> redirect(to: ~p"/invoice_recipients/#{invoice_recipient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, invoice_recipient: invoice_recipient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_recipient = InvoiceRecipient.get!(id)
    {:ok, _invoice_recipient} = InvoiceRecipient.delete(invoice_recipient)

    conn
    |> put_flash(:info, "Invoice recipient deleted successfully.")
    |> redirect(to: ~p"/invoice_recipients")
  end
end
