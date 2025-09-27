defmodule Exenvoice.Event do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Exenvoice.Repo
  alias Exenvoice.Event

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

  @doc """
  Returns the list of events.

  ## Examples

      iex> list()
      [%Event{}, ...]

  """
  def list do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get!(123)
      %Event{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Event{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete(event)
      {:ok, %Event{}}

      iex> delete(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end
end
