defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    prepare_word = fn(word) ->
      word
      |> String.downcase
      |> String.codepoints
      |> Enum.sort
    end

    prepared_base = prepare_word.(base)

    Enum.reduce(candidates, [], fn(c, acc) ->
      candidate = prepare_word.(c)
      with true <- String.downcase(base) !== String.downcase(c),
           true <- length(prepared_base) == length(candidate),
           true <- prepared_base == candidate do
          acc ++ [c]
      else
          false -> acc
      end
    end)
  end
end
