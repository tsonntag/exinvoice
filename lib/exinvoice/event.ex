defmodule Exinvoice.Event do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Exinvoice.{Event, Invoice, Patient, Repo}

  schema "events" do
    field :summary, :string
    field :from_datetime, :utc_datetime
    field :to_datetime, :utc_datetime

    belongs_to :patient, Patient
    belongs_to :invoice_item, InvoiceItem

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

  def first_and_last_date_of_month(%Date{} = month_date) do
    first_day = Date.beginning_of_month(month_date)
    last_day = Date.end_of_month(first_day)
    midnight = ~T[00:00:00]
    tz = "Europe/Berlin"
    {:ok, time_min} = DateTime.new(first_day, midnight, tz)
    {:ok, time_max} = DateTime.new(last_day, midnight, tz)
    {time_min, time_max}
  end

  def list_for_year_month(year, month) do
    {:ok, month_date} = Date.new(year, month, 1)
    list_for_year_month(month_date)
  end

  def list_for_year_month(month_date) do
    {from_date, to_date} = Event.first_and_last_date_of_month(month_date)

    from(event in Event,
      where: event.from_datetime >= ^from_date and event.from_datetime <= ^to_date
    )
    |> Repo.all()
  end
end
