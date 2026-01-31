defmodule MyDiet.Repo do
  use Ecto.Repo,
    otp_app: :my_diet,
    adapter: Ecto.Adapters.Postgres
end
