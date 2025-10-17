defmodule ExinvoiceWeb.Router do
  use ExinvoiceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ExinvoiceWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExinvoiceWeb do
    pipe_through :browser

    get "/", PageController, :home
    resources "/events", EventController
    resources "/invoice_recipients", InvoiceRecipientController
    resources "/invoices", InvoiceController
    resources "/invoice_items", InvoiceItemController
    resources "/patients", PatientController

    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Form, :new
    live "/users/:id", UserLive.Show, :show
    live "/users/:id/edit", UserLive.Form, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExinvoiceWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:exinvoice, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ExinvoiceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
