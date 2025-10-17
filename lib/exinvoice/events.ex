defmodule Exinvoice.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Exinvoice.Repo

  alias Exinvoice.Events.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
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
