ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(MyDiet.Repo, :manual)

# Start the ExMachina application
{:ok, _} = Application.ensure_all_started(:ex_machina)
