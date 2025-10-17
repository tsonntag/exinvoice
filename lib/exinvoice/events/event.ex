defmodule Exinvoice.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Exinvoice.Patients.Patient
  alias Exinvoice.Invoices.InvoiceItem

  schema "events" do
    field :summary, :string
    field :from_datetime, :utc_datetime
    field :to_datetime, :utc_datetime

    belongs_to :patient, Patient
    belongs_to :invoice_item, InvoiceItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:summary, :from_datetime, :to_datetime])
    |> validate_required([:summary, :from_datetime, :to_datetime])
  end
end
