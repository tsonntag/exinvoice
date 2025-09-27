defmodule ExenvoiceWeb.PatientController do
  use ExenvoiceWeb, :controller

  alias Exenvoice.Patient

  def index(conn, _params) do
    patients = Patient.list()
    render(conn, :index, patients: patients)
  end

  def new(conn, _params) do
    changeset = Patient.change(%Patient{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"patient" => patient_params}) do
    case Patient.create(patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient created successfully.")
        |> redirect(to: ~p"/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Patient.get!(id)
    render(conn, :show, patient: patient)
  end

  def edit(conn, %{"id" => id}) do
    patient = Patient.get!(id)
    changeset = Patient.change(patient)
    render(conn, :edit, patient: patient, changeset: changeset)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Patient.get!(id)

    case Patient.update(patient, patient_params) do
      {:ok, patient} ->
        conn
        |> put_flash(:info, "Patient updated successfully.")
        |> redirect(to: ~p"/patients/#{patient}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, patient: patient, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Patient.get!(id)
    {:ok, _patient} = Patient.delete(patient)

    conn
    |> put_flash(:info, "Patient deleted successfully.")
    |> redirect(to: ~p"/patients")
  end
end
