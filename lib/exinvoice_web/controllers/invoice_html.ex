defmodule ExinvoiceWeb.InvoiceHTML do
  use ExinvoiceWeb, :html

  embed_templates "invoice_html/*"

  @doc """
  Renders a invoice form.

  The form is defined in the template at
  invoice_html/invoice_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def invoice_form(assigns)
end
