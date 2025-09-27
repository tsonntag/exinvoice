defmodule Exenvoice.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :no, :string
      add :date, :date
      add :year_month, :date
      add :diagnosis, :string
      add :sum_events, :boolean, default: false, null: false
      add :patient_id, references(:patients, on_delete: :nothing)
      add :invoice_recipient_id, references(:invoice_recipients, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:invoices, [:patient_id])
    create index(:invoices, [:invoice_recipient_id])
  end
end
