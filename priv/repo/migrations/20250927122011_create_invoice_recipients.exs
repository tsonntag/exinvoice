defmodule Exinvoice.Repo.Migrations.CreateInvoiceRecipients do
  use Ecto.Migration

  def change do
    create table(:invoice_recipients) do
      add :salutation, :string
      add :first_name, :string
      add :last_name, :string
      add :address_line_1, :string
      add :address_line_2, :string
      add :street, :string
      add :zip, :string
      add :city, :string
      add :invoice_salutation, :string

      timestamps(type: :utc_datetime)
    end
  end
end
