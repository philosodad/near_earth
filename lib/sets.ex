defmodule Sets do
  import EnvHelper
  system_env(:nasa_api_key, "DEMO_KEY")
  system_env(:nasa_neo_url, "https://api.nasa.gov/neo/rest/v1/neo/")
  app_env(:http, [:near_earth, :http], NearEarth.Http)
end
