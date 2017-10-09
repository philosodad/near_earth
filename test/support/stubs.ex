defmodule NearEarthTest.Stubs do
  def asteroid do
    {:ok, asteroid} = File.read("test/support/asteroid.json")
    asteroid
  end

  def asteroids do
    {:ok, asteroids} = File.read("test/support/asteroids.json")
    asteroids
  end
end
