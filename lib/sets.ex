defmodule Sets do
  import EnvHelper
  system_env(:nasa_api_key, "DEMO_KEY")
  app_env(:http, [:near_earth, :http], NearEarth.Http)
end
