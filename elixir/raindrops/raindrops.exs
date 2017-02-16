defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @prime_factor_mappings %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @prime_factors [3,5,7]

  @spec convert(pos_integer) :: String.t
  def convert(number) do
    rain_drops = fn(number, factor) ->
      rem(number,factor) == 0 end

    convertion = Enum.reduce(@prime_factors, "", fn(factor, acc) ->
      case rain_drops.(number, factor) do
        true -> acc <> Map.get(@prime_factor_mappings, factor)
        false -> acc
      end
    end)
    respond(convertion, number)
  end
  defp respond(convertion, number) when convertion == "", do: to_string(number)
  defp respond(convertion, number) do convertion end
end
