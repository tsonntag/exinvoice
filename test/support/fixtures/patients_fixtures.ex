defmodule Exinvoice.PatientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Exinvoice.Patients` context.
  """

  @doc """
  Generate a patient.
  """
  def patient_fixture(attrs \\ %{}) do
    {:ok, patient} =
      attrs
      |> Enum.into(%{
        diagnosis: "some diagnosis",
        first_name: "some first_name",
        last_name: "some last_name",
        minutes_per_unit: 42,
        nickname: "some nickname",
        price_per_unit: 42,
        service_description: "some service_description",
        show_events: true
      })
      |> Exinvoice.Patients.create_patient()

    patient
  end
end
