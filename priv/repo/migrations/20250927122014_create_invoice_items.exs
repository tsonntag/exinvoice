defmodule Exinvoice.Repo.Migrations.CreateInvoiceItems do
  use Ecto.Migration

  def change do
    create table(:invoice_items) do
      add :no, :integer
      add :service_description, :string
      add :price_per_unit, :integer
      add :minutes_per_unit, :integer
      add :show_events, :boolean, default: false, null: false
      add :invoice_id, references(:invoices, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:invoice_items, [:invoice_id])
  end
end
