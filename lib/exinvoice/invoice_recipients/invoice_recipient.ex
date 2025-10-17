defmodule Exinvoice.InvoiceRecipients.InvoiceRecipient do
  use Ecto.Schema
  import Ecto.Changeset

  alias Exinvoice.Invoices.Invoice

  schema "invoice_recipients" do
    field :salutation, :string
    field :first_name, :string
    field :last_name, :string
    field :address_line_1, :string
    field :address_line_2, :string
    field :street, :string
    field :zip, :string
    field :city, :string
    field :invoice_salutation, :string
    has_many :invoices, Invoice

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invoice_recipient, attrs) do
    invoice_recipient
    |> cast(attrs, [
      :salutation,
      :first_name,
      :last_name,
      :address_line_1,
      :address_line_2,
      :street,
      :zip,
      :city,
      :invoice_salutation
    ])
    |> validate_required([
      :salutation,
      :first_name,
      :last_name,
      :street,
      :zip,
      :city,
      :invoice_salutation
    ])
  end

end
