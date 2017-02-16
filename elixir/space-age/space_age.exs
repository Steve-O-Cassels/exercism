defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :uranus | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """

  @earth_orbital_year_seconds 31_557_600
  @earth_orbital_year_ratio %{
    earth: 1.0,
    mercury: 0.2408467,
    venus: 0.61519726,
    mars: 1.8808158,
    jupiter: 11.862615,
    saturn: 29.447498,
    uranus: 84.016846,
    neptune: 164.79132
  }

  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
   with {:ok, ratio} <- Map.fetch(@earth_orbital_year_ratio, planet) do
     planet_year_seconds = @earth_orbital_year_seconds * ratio
     seconds / planet_year_seconds
   end
  end
end
