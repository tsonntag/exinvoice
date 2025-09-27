defmodule Exenvoice.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :summary, :string
    field :from_datetime, :utc_datetime
    field :to_datetime, :utc_datetime
    field :invoice_item_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:summary, :from_datetime, :to_datetime])
    |> validate_required([:summary, :from_datetime, :to_datetime])
  end
end
