defmodule Exinvoice.Repo.Migrations.AddPatientIdToEvents do
  use Ecto.Migration

  def change do

    alter table("events") do
      add_if_not_exists :patient_id, references(:patients, on_delete: :nothing)
    end

    create index(:events, [:patient_id])
  end
end
