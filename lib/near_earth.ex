defmodule NearEarth do

  # get an asteroid by id
  # returns the asteroid body
  def get_asteroid asteroid do
    case Sets.http.get("https://api.nasa.gov/neo/rest/v1/neo/#{asteroid}?api_key=DEMO_KEY") do
      {:ok, response = %{status_code: 200}} -> Poison.decode(response.body)
      {:ok, %{status_code: 404}} -> {:error, :not_found}
    end
  end
end
