defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    limit-1
    |> multiples_of_factors(factors)
    |> Enum.reduce(0, fn(x,acc) -> x + acc end)
  end
  defp multiples_of_factors(limit, factors) do
    Enum.reduce(factors, [], fn(factor, acc) ->
      result = trunc(limit / factor)
      |> multiples_of_factor(factor)
      acc ++ result
    end)
    |> Enum.uniq
  end
  defp multiples_of_factor(0,_factor), do: []
  defp multiples_of_factor(times,factor) when times > 0 do
     for n <- 1..times, do: n * factor
  end
end
