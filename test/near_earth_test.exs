defmodule NearEarthTest do
  use ExUnit.Case
  alias NearEarthTest.Stubs
  require Sets
  doctest NearEarth

  setup do
    not_found = %HTTPoison.Response{status_code: 404}
    asteroid_response = %HTTPoison.Response{status_code: 200, headers: [{"Content-Type", "application/json:charset=UTF-8"}], body: Stubs.asteroid}
    asteroids_response = %HTTPoison.Response{status_code: 200, headers: [{"Content-Type", "application/json:charset=UTF-8"}], body: Stubs.asteroids}
    on_exit fn -> 
      Stash.clear(:near_earth)
    end
    {:ok, %{asteroids: asteroids_response, asteroid: asteroid_response, not_found: not_found}}
  end

  test "retrieves asteroid by designation", context do
    id = "3542519"
    Stash.set(:near_earth, "#{Sets.nasa_neo_url}#{id}?api_key=#{Sets.nasa_api_key}", {:ok, context.asteroid})
    {:ok, asteroid_response} = NearEarth.get_asteroid(id)
    assert asteroid_response["name"] == "465633 (2009 JR5)"
  end

  test "will return a not found message for a missing asteroid", context do
    Stash.set(:near_earth, "#{Sets.nasa_neo_url}fakevalue?api_key=#{Sets.nasa_api_key}", {:ok, context.not_found})
    assert {:error, :not_found} == NearEarth.get_asteroid("fakevalue")
  end

  test "retrieves today's asteroids", context do
    today = Date.utc_today
            |> Date.to_string
    tomorrow = Faker.Date.forward(1)
               |> Date.to_string
    Stash.set(:near_earth, "#{Sets.nasa_neo_url}feed?start_date=#{today}&end_date=#{tomorrow}&api_key=#{Sets.nasa_api_key}", {:ok, context.asteroids})
    {:ok, asteroids} = NearEarth.get_today()
    assert asteroids == context.asteroids.body 
                        |> Poison.decode!
  end
end
