defmodule River.Repo do
  use Ecto.Repo,
    otp_app: :river,
    adapter: Ecto.Adapters.Postgres
end
