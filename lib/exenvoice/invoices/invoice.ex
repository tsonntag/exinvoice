defmodule Exenvoice.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    field :no, :string
    field :date, :date
    field :year_month, :date
    field :diagnosis, :string
    field :sum_events, :boolean, default: false
    field :patient_id, :id
    field :invoice_recipient_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:no, :date, :year_month, :diagnosis, :sum_events])
    |> validate_required([:no, :date, :year_month, :diagnosis, :sum_events])
  end
end
