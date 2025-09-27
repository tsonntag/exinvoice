defmodule ExinvoiceWeb.PageController do
  use ExinvoiceWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
