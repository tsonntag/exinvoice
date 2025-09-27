defmodule ExenvoiceWeb.PageController do
  use ExenvoiceWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
