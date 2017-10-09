defmodule NearEarth do

  # get an asteroid by id
  # returns the asteroid body
  def get_asteroid asteroid do
    case Sets.http.get("#{Sets.nasa_neo_url}#{asteroid}?api_key=#{Sets.nasa_api_key}") do
      {:ok, response = %{status_code: 200}} -> Poison.decode(response.body)
      {:ok, %{status_code: 404}} -> {:error, :not_found}
    end
  end

  def get_today do
    today = Date.utc_today()
            |> Date.to_string()
    tomorrow = :calendar.universal_time
               |> :calendar.datetime_to_gregorian_seconds
               |> (&(&1 + 86400)).()
               |> :calendar.gregorian_seconds_to_datetime
               |> elem(0)
               |> Date.from_erl
               |> elem(1)
               |> Date.to_string 
    case Sets.http.get("#{Sets.nasa_neo_url}feed?start_date=#{today}&end_date=#{tomorrow}&api_key=#{Sets.nasa_api_key}") do
      {:ok, response = %{status_code: 200}} -> Poison.decode(response.body)
      #{:ok, %{status_code: 404}} -> {:error, :not_found}
    end

  end
end
