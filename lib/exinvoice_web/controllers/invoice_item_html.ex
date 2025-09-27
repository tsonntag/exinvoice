defmodule ExinvoiceWeb.InvoiceItemHTML do
  use ExinvoiceWeb, :html

  embed_templates "invoice_item_html/*"

  @doc """
  Renders a invoice_item form.

  The form is defined in the template at
  invoice_item_html/invoice_item_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def invoice_item_form(assigns)
end
