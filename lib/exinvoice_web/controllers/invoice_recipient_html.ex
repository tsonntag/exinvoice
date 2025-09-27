defmodule ExinvoiceWeb.InvoiceRecipientHTML do
  use ExinvoiceWeb, :html

  embed_templates "invoice_recipient_html/*"

  @doc """
  Renders a invoice_recipient form.

  The form is defined in the template at
  invoice_recipient_html/invoice_recipient_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def title(invoice_recipient) do
    invoice_recipient.first_name <> " " <> invoice_recipient.last_name
  end

end
