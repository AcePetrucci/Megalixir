defmodule Megalixir.Repo do
  use Ecto.Repo,
    otp_app: :megalixir,
    adapter: Ecto.Adapters.Postgres
end
