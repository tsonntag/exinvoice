defmodule ExinvoiceWeb.PatientHTML do
  use ExinvoiceWeb, :html

  embed_templates "patient_html/*"

  @doc """
  Renders a patient form.

  The form is defined in the template at
  patient_html/patient_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def patient_form(assigns)

  def title(patient) do
    patient.first_name <> " " <> patient.last_name
  end
end
