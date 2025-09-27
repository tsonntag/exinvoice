defmodule ExenvoiceWeb.EventController do
  use ExenvoiceWeb, :controller

  alias Exenvoice.Event

  def index(conn, _params) do
    events = Event.list()
    render(conn, :index, events: events)
  end

  def new(conn, _params) do
    changeset = Event.change(%Event{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    case Event.create(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: ~p"/Event/#{event}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Event.get!(id)
    render(conn, :show, event: event)
  end

  def edit(conn, %{"id" => id}) do
    event = Event.get!(id)
    changeset = Event.change_event(event)
    render(conn, :edit, event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Event.get!(id)

    case Event.update(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: ~p"/Event/#{event}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Event.get!(id)
    {:ok, _event} = Event.delete(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: ~p"/Event")
  end
end
