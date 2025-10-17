defmodule ExinvoiceWeb.PatientController do
  use ExinvoiceWeb, :controller

  alias Exinvoice.Repo
  alias Exinvoice.Patients
  alias Exinvoice.Patients.Patient

  def index(conn, _params) do
    patients = Patients.list()
    render(conn, :index, patients: patients)
  end

  def new(conn, _params) do
    changeset = Patients.change(%Patient{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"patient" => patient_params}) do
    case Patients.create(patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient created successfully.")
        |> redirect(to: ~p"/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Patients.get_event!(id) |> Repo.preload([:invoice_recipient, :events])
    |> IO.inspect(label: "Preloaded Patient")
    render(conn, :show, patient: patient)
  end

  def edit(conn, %{"id" => id}) do
    patient = Patients.get_event!(id)
    changeset = Patients.change(patient)
    render(conn, :edit, patient: patient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Patients.get_event!(id)

    case Patients.update(patient, patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient updated successfully.")
        |> redirect(to: ~p"/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, patient: patient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Patients.get_event!(id)
    {:ok, _patient} = Patients.delete(patient)

    conn
    |> put_flash(:info, "Patient deleted successfully.")
    |> redirect(to: ~p"/patients")
  end
end
