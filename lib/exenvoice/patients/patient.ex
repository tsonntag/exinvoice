defmodule Exenvoice.Patients.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :nickname, :string
    field :first_name, :string
    field :last_name, :string
    field :diagnosis, :string
    field :service_description, :string
    field :price_per_unit, :integer
    field :minutes_per_unit, :integer
    field :show_events, :boolean, default: false
    field :invoice_recipient_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:nickname, :first_name, :last_name, :diagnosis, :service_description, :price_per_unit, :minutes_per_unit, :show_events])
    |> validate_required([:nickname, :first_name, :last_name, :diagnosis, :service_description, :price_per_unit, :minutes_per_unit, :show_events])
  end
end
