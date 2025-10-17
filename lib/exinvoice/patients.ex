defmodule Exinvoice.Patients do
  @moduledoc """
  The Patients context.
  """

  import Ecto.Query, warn: false
  alias Exinvoice.Repo

  alias Exinvoice.Patients.Patient
  alias Exinvoice.Events.Event

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list_patients()
      [%Patient{}, ...]

  """
  def list_patients() do
    Repo.all(Patient)
  end

  @doc """
  Gets a single patient.

  Raises `Ecto.NoResultsError` if the Patient does not exist.

  ## Examples

      iex> get_patient!(123)
      %Patient{}

      iex> get.patient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patient!(id) do
    Repo.get!(Patient, id)
  end

  @doc """
  Creates a patient.

  ## Examples

      iex> create_patient(%{field: value})
      {:ok, %Patient{}}

      iex> create_patient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patient(attrs) do
    %Patient{}
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patient.

  ## Examples

      iex> update_patient(patient, %{field: new_value})
      {:ok, %Patient{}}

      iex> update_patient(patient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patient(%Patient{} = patient, attrs) do
    patient
    |> Patient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patient.

  ## Examples

      iex> delete_patient(patient)
      {:ok, %Patient{}}

      iex> delete_patient(patient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patient(%Patient{} = patient) do
    Repo.delete(patient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patient changes.

  ## Examples
      iex> change_patient(patient)
      %Ecto.Changeset{data: %Patient{}}

  """
  def change_patient(%Patient{} = patient, attrs \\ %{}) do
    Patient.changeset(patient, attrs)
  end

  def find_patient_by_nickname(nickname) do
    term = "%#{nickname}%"
    query = from p in Patient, where: ilike(p.nickname, ^term)
    Repo.one(query)
  end

  def add_event_to_patient!(%Patient{} = patient, %Event{} = event) do
    IO.inspect(event, label: "Adding event to patient #{patient.id}")

    event
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_change(:patient_id, patient.id)
    |> Repo.update()
  end

  def add_events_to_patient!(%Patient{} = patient, events) do
    for event <- events do
      add_event_to_patient!(patient, event)
    end
  end
end
