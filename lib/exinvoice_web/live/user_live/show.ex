defmodule ExinvoiceWeb.UserLive.Show do
  use ExinvoiceWeb, :live_view

  alias Exinvoice.Users

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        User {@user.id}
        <:subtitle>This is a user record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/users"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/users/#{@user}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit user
          </.button>
          <button phx-click="inc_age">+</button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@user.name}</:item>
        <:item title="Age">{@user.age}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show User")
     |> assign(:user, Users.get_user!(id))}
  end


  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Users.get_user!(id)
    {:ok, _} = Users.delete_user(user)

    {:noreply, stream_delete(socket, :users, user)}
  end

  @impl true
  def handle_event("inc_age", _params, socket) do
    user = socket.assigns.user
    IO.inspect(user, label: "User before incrementing age")
    {:ok, updated_user } = Users.update_user(user, %{age: user.age + 1})
    IO.inspect(updated_user, label: "User after incrementing age")

    {:noreply, assign(socket, :user, updated_user)}
  end


end
