defmodule NearEarth.TestHttp do
  use HTTPoison.Base

  def get("https://api.nasa.gov/neo/rest/v1/neo/fakevalue?api_key=DEMO_KEY") do
    {:ok, %HTTPoison.Response{headers: [], status_code: 404}}
  end

  def get(args) do
    HTTPoison.get(args)
  end
end
