defmodule Exenvoice.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :nickname, :string
      add :first_name, :string
      add :last_name, :string
      add :diagnosis, :string
      add :service_description, :string
      add :price_per_unit, :integer
      add :minutes_per_unit, :integer
      add :show_events, :boolean, default: false, null: false
      add :invoice_recipient_id, references(:invoice_recipients, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:patients, [:invoice_recipient_id])
  end
end
