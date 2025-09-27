defmodule Exenvoice.InvoiceRecipient do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Exenvoice.Repo
  alias Exenvoice.InvoiceRecipient

  schema "invoice_recipients" do
    field :salutation, :string
    field :first_name, :string
    field :last_name, :string
    field :address_line_1, :string
    field :address_line_2, :string
    field :street, :string
    field :zip, :string
    field :city, :string
    field :invoice_salutation, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(invoice_recipient, attrs) do
    invoice_recipient
    |> cast(attrs, [
      :salutation,
      :first_name,
      :last_name,
      :address_line_1,
      :address_line_2,
      :street,
      :zip,
      :city,
      :invoice_salutation
    ])
    |> validate_required([
      :salutation,
      :first_name,
      :last_name,
      :address_line_1,
      :address_line_2,
      :street,
      :zip,
      :city,
      :invoice_salutation
    ])
  end

  @doc """
  Returns the list of invoice_recipients.

  ## Examples

      iex> list()
      [%InvoiceRecipient{}, ...]

  """
  def list do
    Repo.all(InvoiceRecipient)
  end

  @doc """
  Gets a single invoice_recipient.

  Raises `Ecto.NoResultsError` if the Invoice recipient does not exist.

  ## Examples

      iex> get!(123)
      %InvoiceRecipient{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(InvoiceRecipient, id)

  @doc """
  Creates a invoice_recipient.

  ## Examples

      iex> create(%{field: value})
      {:ok, %InvoiceRecipient{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs) do
    %InvoiceRecipient{}
    |> InvoiceRecipient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invoice_recipient.

  ## Examples

      iex> update(invoice_recipient, %{field: new_value})
      {:ok, %InvoiceRecipient{}}

      iex> update(invoice_recipient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%InvoiceRecipient{} = invoice_recipient, attrs) do
    invoice_recipient
    |> InvoiceRecipient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invoice_recipient.

  ## Examples

      iex> delete(invoice_recipient)
      {:ok, %InvoiceRecipient{}}

      iex> delete(invoice_recipient)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%InvoiceRecipient{} = invoice_recipient) do
    Repo.delete(invoice_recipient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice_recipient changes.

  ## Examples

      iex> change(invoice_recipient)
      %Ecto.Changeset{data: %InvoiceRecipient{}}

  """
  def change(%InvoiceRecipient{} = invoice_recipient, attrs \\ %{}) do
    InvoiceRecipient.changeset(invoice_recipient, attrs)
  end
end
