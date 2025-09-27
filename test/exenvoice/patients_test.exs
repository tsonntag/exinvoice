defmodule Exinvoice.PatientsTest do
  use Exinvoice.DataCase

  alias Exinvoice.Patients

  describe "patients" do
    alias Exinvoice.Patients.Patient

    import Exinvoice.PatientsFixtures

    @invalid_attrs %{nickname: nil, first_name: nil, last_name: nil, diagnosis: nil, service_description: nil, price_per_unit: nil, minutes_per_unit: nil, show_events: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      assert Patients.list_patients() == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Patients.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{nickname: "some nickname", first_name: "some first_name", last_name: "some last_name", diagnosis: "some diagnosis", service_description: "some service_description", price_per_unit: 42, minutes_per_unit: 42, show_events: true}

      assert {:ok, %Patient{} = patient} = Patients.create_patient(valid_attrs)
      assert patient.nickname == "some nickname"
      assert patient.first_name == "some first_name"
      assert patient.last_name == "some last_name"
      assert patient.diagnosis == "some diagnosis"
      assert patient.service_description == "some service_description"
      assert patient.price_per_unit == 42
      assert patient.minutes_per_unit == 42
      assert patient.show_events == true
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patients.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{nickname: "some updated nickname", first_name: "some updated first_name", last_name: "some updated last_name", diagnosis: "some updated diagnosis", service_description: "some updated service_description", price_per_unit: 43, minutes_per_unit: 43, show_events: false}

      assert {:ok, %Patient{} = patient} = Patients.update_patient(patient, update_attrs)
      assert patient.nickname == "some updated nickname"
      assert patient.first_name == "some updated first_name"
      assert patient.last_name == "some updated last_name"
      assert patient.diagnosis == "some updated diagnosis"
      assert patient.service_description == "some updated service_description"
      assert patient.price_per_unit == 43
      assert patient.minutes_per_unit == 43
      assert patient.show_events == false
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Patients.update_patient(patient, @invalid_attrs)
      assert patient == Patients.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Patients.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Patients.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Patients.change_patient(patient)
    end
  end
end
