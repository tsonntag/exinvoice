defmodule Exinvoice.InvoiceItem do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Exinvoice.Repo

  alias Exinvoice.InvoiceItem

  schema "invoice_items" do
    field :no, :integer
    field :service_description, :string
    field :price_per_unit, :integer
    field :minutes_per_unit, :integer
    field :show_events, :boolean, default: false
    field :invoice_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invoice_item, attrs) do
    invoice_item
    |> cast(attrs, [:no, :service_description, :price_per_unit, :minutes_per_unit, :show_events])
    |> validate_required([
      :no,
      :service_description,
      :price_per_unit,
      :minutes_per_unit,
      :show_events
    ])
  end

  @doc """
  Returns the list of invoice_items.

  ## Examples

      iex> list()
      [%InvoiceItem{}, ...]

  """
  def list() do
    Repo.all(InvoiceItem)
  end

  @doc """
  Gets a single invoice_item.

  Raises `Ecto.NoResultsError` if the Invoice item does not exist.

  ## Examples

      iex> get!(123)
      %InvoiceItem{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id) do
    Repo.get!(InvoiceItem, id)
  end

  @doc """
  Creates a invoice_item.

  ## Examples

      iex> create(%{field: value})
      {:ok, %InvoiceItem{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs) do
    %InvoiceItem{}
    |> InvoiceItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invoice_item.

  ## Examples

      iex> update(invoice_item, %{field: new_value})
      {:ok, %InvoiceItem{}}

      iex> update(invoice_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%InvoiceItem{} = invoice_item, attrs) do
    invoice_item
    |> InvoiceItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invoice_item.

  ## Examples

      iex> delete(invoice_item)
      {:ok, %InvoiceItem{}}

      iex> delete(invoice_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%InvoiceItem{} = invoice_item) do
    Repo.delete(invoice_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice_item changes.

  ## Examples

      iex> change_invoice_item(invoice_item)
      %Ecto.Changeset{data: %InvoiceItem{}}

  """
  def change(%InvoiceItem{} = invoice_item, attrs \\ %{}) do
    InvoiceItem.changeset(invoice_item, attrs)
  end
end
