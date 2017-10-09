defmodule NearEarth.TestHttp do
  use HTTPoison.Base

  def get(route) do
    Stash.get(:near_earth, route)
  end

end
