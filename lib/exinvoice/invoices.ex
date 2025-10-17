defmodule Exinvoice.Invoices do
  @moduledoc """
  The Invoices context.
  """
  alias Exinvoice.Repo
  alias Exinvoice.Patients
  alias Exinvoice.Patients.Patient
  alias Exinvoice.Events
  alias Exinvoice.Invoices.Invoice

  @doc """
  Returns the list of invoices.

  ## Examples

      iex> list_invoices()
      [%Invoice{}, ...]

  """
  def list_invoices() do
    Repo.all(Invoice)
  end

  @doc """
  Gets a single invoice.

  Raises `Ecto.NoResultsError` if the Invoice does not exist.

  ## Examples

      iex> get_invoice!(123)
      %Invoice{}

      iex> get_invoice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_invoice!(id), do: Repo.get!(Invoice, id)

  @doc """
  Creates a invoice.

  ## Examples

      iex> create_invoice(%{field: value})
      {:ok, %Invoice{}}

      iex> create_invoice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_invoice(attrs) do
    %Invoice{}
    |> Invoice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invoice.

  ## Examples

      iex> update_invoice(invoice, %{field: new_value})
      {:ok, %Invoice{}}

      iex> update_invoice(invoice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invoice(%Invoice{} = invoice, attrs) do
    invoice
    |> Invoice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invoice.

  ## Examples

      iex> delete_invoice(invoice)
      {:ok, %Invoice{}}

      iex> delete_invoice(invoice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invoice(%Invoice{} = invoice) do
    Repo.delete(invoice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice changes.

  ## Examples

      iex> change_invoice(invoice)
      %Ecto.Changeset{data: %Invoice{}}

  """
  def change_invoice(%Invoice{} = invoice, attrs \\ %{}) do
    Invoice.changeset(invoice, attrs)
  end

  def create_for_year_month(year, month) do
    {:ok, month_date} = Date.new(year, month, 1)
    create_for_year_month(month_date)
  end

  def create_for_year_month(month_date) do
    events = Events.list_for_year_month(month_date)

    IO.inspect(events, label: "Events")

    patients_to_events =
      events
      |> Enum.map(fn event -> {Patients.find_by_nickname(event.summary), event} end)
      |> Enum.filter(fn {patient, _event} -> patient end)
      |> Enum.group_by(fn {patient, _event} -> patient end)

    for { patient, pats_evs } <- patients_to_events do
        events = Enum.map(pats_evs, fn {_patient, event} -> event end)
        Patients.add_events!(patient, events)

  #        invoice = Invoice.create(patient, date, year_month, events)
#   IO.inspect(from_date, label: "From Date")
#   IO.inspect(to_date, label: "To Date")
    end
  end

  def invoice_from_patient(%Patient{} = patient) do
    %Invoice{
      patient_id: patient.id,
      diagnosis: patient.diagnosis,
      invoice_recipient_id: patient.invoice_recipient_id,
      sum_events: patient.sum_events
    }

  end

    #
# invoice = Invoice.insert(
    #     no = max(Invoice.no, scope: year_month.year) + 1
    #     date,
    #     year_month
    #     diagnosis = patient.diagnosis
    #     invoice_recipient = patient.invoice_recipient
    #     sum_events = patient.sum_events
    #    )

end
