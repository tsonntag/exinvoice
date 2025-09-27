defmodule Exinvoice.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :summary, :string
      add :from_datetime, :utc_datetime
      add :to_datetime, :utc_datetime
      add :invoice_item_id, references(:invoice_items, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:invoice_item_id])
  end
end
