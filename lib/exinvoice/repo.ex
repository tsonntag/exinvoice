defmodule Exinvoice.Repo do
  use Ecto.Repo,
    otp_app: :exinvoice,
    adapter: Ecto.Adapters.Postgres
end
