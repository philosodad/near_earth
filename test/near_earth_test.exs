defmodule NearEarthTest do
  use ExUnit.Case
  doctest NearEarth

  test "retrieves asteroids by designation" do
    {:ok, asteroid} = NearEarth.get_asteroid("3542519")
    assert asteroid["name"] == "(2010 PK9)"
  end
end
