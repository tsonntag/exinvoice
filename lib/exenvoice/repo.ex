defmodule Exenvoice.Repo do
  use Ecto.Repo,
    otp_app: :exenvoice,
    adapter: Ecto.Adapters.Postgres
end
