defmodule Exinvoice.Patient do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Exinvoice.{Event, InvoiceRecipient, Patient, Repo}

  schema "patients" do
    field :nickname, :string
    field :first_name, :string
    field :last_name, :string
    field :diagnosis, :string
    field :service_description, :string
    field :price_per_unit, :integer
    field :minutes_per_unit, :integer
    field :show_events, :boolean, default: false

    belongs_to :invoice_recipient, InvoiceRecipient
    has_many :events, Event

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [
      :nickname,
      :first_name,
      :last_name,
      :diagnosis,
      :service_description,
      :price_per_unit,
      :minutes_per_unit,
      :show_events
    ])
    |> validate_required([
      :nickname,
      :first_name,
      :last_name,
      :diagnosis,
      :service_description,
      :price_per_unit,
      :minutes_per_unit,
      :show_events
    ])
  end

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list()
      [%Patient{}, ...]

  """
  def list do
    Repo.all(Patient)
  end

  @doc """
  Gets a single patient.

  Raises `Ecto.NoResultsError` if the Patient does not exist.

  ## Examples

      iex> get!(123)
      %Patient{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Patient, id)

  @doc """
  Creates a patient.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Patient{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs) do
    %Patient{}
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patient.

  ## Examples

      iex> update(patient, %{field: new_value})
      {:ok, %Patient{}}

      iex> update(patient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Patient{} = patient, attrs) do
    patient
    |> Patient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patient.

  ## Examples

      iex> delete(patient)
      {:ok, %Patient{}}

      iex> delete(patient)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Patient{} = patient) do
    Repo.delete(patient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patient changes.

  ## Examples
      iex> change(patient)
      %Ecto.Changeset{data: %Patient{}}

  """
  def change(%Patient{} = patient, attrs \\ %{}) do
    Patient.changeset(patient, attrs)
  end

  def find_by_nickname(nickname) do
    term = "%#{nickname}%"
    query = from p in Patient, where: ilike(p.nickname,^term)
    Repo.one(query)
  end

  def add_events(%Patient{} = patient, events) do
#   for event in events do


#   end
#   patient
#   |> Repo.preload(:events)
#   |> Ecto.Changeset.put_assoc(:events, [event_changeset])
#   |> Repo.update()
  end
end
