defmodule Exinvoice.Invoices.InvoiceItem do
  use Ecto.Schema
  import Ecto.Changeset

  alias Exinvoice.Invoices.Invoice
  alias Exinvoice.Events.Event

  schema "invoice_items" do
    field :no, :integer
    field :service_description, :string
    field :price_per_unit, :integer
    field :minutes_per_unit, :integer
    field :show_events, :boolean, default: false

    belongs_to :invoice, Invoice
    has_many :events, Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invoice_item, attrs) do
    invoice_item
    |> cast(attrs, [:no, :service_description, :price_per_unit, :minutes_per_unit, :show_events])
    |> validate_required([
      :no,
      :service_description,
      :price_per_unit,
      :minutes_per_unit,
      :show_events
    ])
  end


end
