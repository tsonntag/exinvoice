defmodule Exenvoice.Invoice do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Exenvoice.Repo
  alias Exenvoice.Invoice

  schema "invoices" do
    field :no, :string
    field :date, :date
    field :year_month, :date
    field :diagnosis, :string
    field :sum_events, :boolean, default: false
    field :patient_id, :id
    field :invoice_recipient_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:no, :date, :year_month, :diagnosis, :sum_events])
    |> validate_required([:no, :date, :year_month, :diagnosis, :sum_events])
  end

  @doc """
  Returns the list of invoices.

  ## Examples

      iex> list()
      [%Invoice{}, ...]

  """
  def list do
    Repo.all(Invoice)
  end

  @doc """
  Gets a single invoice.

  Raises `Ecto.NoResultsError` if the Invoice does not exist.

  ## Examples

      iex> get!(123)
      %Invoice{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Invoice, id)

  @doc """
  Creates a invoice.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Invoice{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs) do
    %Invoice{}
    |> Invoice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invoice.

  ## Examples

      iex> update(invoice, %{field: new_value})
      {:ok, %Invoice{}}

      iex> update(invoice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Invoice{} = invoice, attrs) do
    invoice
    |> Invoice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invoice.

  ## Examples

      iex> delete(invoice)
      {:ok, %Invoice{}}

      iex> delete(invoice)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Invoice{} = invoice) do
    Repo.delete(invoice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice changes.

  ## Examples

      iex> change(invoice)
      %Ecto.Changeset{data: %Invoice{}}

  """
  def change_invoice(%Invoice{} = invoice, attrs \\ %{}) do
    Invoice.changeset(invoice, attrs)
  end
end
