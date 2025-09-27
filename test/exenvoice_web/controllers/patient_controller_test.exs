defmodule ExenvoiceWeb.PatientControllerTest do
  use ExenvoiceWeb.ConnCase

  import Exenvoice.PatientsFixtures

  @create_attrs %{nickname: "some nickname", first_name: "some first_name", last_name: "some last_name", diagnosis: "some diagnosis", service_description: "some service_description", price_per_unit: 42, minutes_per_unit: 42, show_events: true}
  @update_attrs %{nickname: "some updated nickname", first_name: "some updated first_name", last_name: "some updated last_name", diagnosis: "some updated diagnosis", service_description: "some updated service_description", price_per_unit: 43, minutes_per_unit: 43, show_events: false}
  @invalid_attrs %{nickname: nil, first_name: nil, last_name: nil, diagnosis: nil, service_description: nil, price_per_unit: nil, minutes_per_unit: nil, show_events: nil}

  describe "index" do
    test "lists all patients", %{conn: conn} do
      conn = get(conn, ~p"/patients")
      assert html_response(conn, 200) =~ "Listing Patients"
    end
  end

  describe "new patient" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/patients/new")
      assert html_response(conn, 200) =~ "New Patient"
    end
  end

  describe "create patient" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/patients", patient: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/patients/#{id}"

      conn = get(conn, ~p"/patients/#{id}")
      assert html_response(conn, 200) =~ "Patient #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/patients", patient: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Patient"
    end
  end

  describe "edit patient" do
    setup [:create_patient]

    test "renders form for editing chosen patient", %{conn: conn, patient: patient} do
      conn = get(conn, ~p"/patients/#{patient}/edit")
      assert html_response(conn, 200) =~ "Edit Patient"
    end
  end

  describe "update patient" do
    setup [:create_patient]

    test "redirects when data is valid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/patients/#{patient}", patient: @update_attrs)
      assert redirected_to(conn) == ~p"/patients/#{patient}"

      conn = get(conn, ~p"/patients/#{patient}")
      assert html_response(conn, 200) =~ "some updated nickname"
    end

    test "renders errors when data is invalid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/patients/#{patient}", patient: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Patient"
    end
  end

  describe "delete patient" do
    setup [:create_patient]

    test "deletes chosen patient", %{conn: conn, patient: patient} do
      conn = delete(conn, ~p"/patients/#{patient}")
      assert redirected_to(conn) == ~p"/patients"

      assert_error_sent 404, fn ->
        get(conn, ~p"/patients/#{patient}")
      end
    end
  end

  defp create_patient(_) do
    patient = patient_fixture()

    %{patient: patient}
  end
end
