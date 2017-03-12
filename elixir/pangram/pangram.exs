defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    a_z =
      Enum.to_list(?a..?z)
      |> to_string
      |> String.codepoints

    uniq_sentence = sentence
    |> String.downcase
    |> String.codepoints
    |> Enum.uniq

    letters_used = Enum.reduce(a_z, [], fn(letter, acc) ->
      if Enum.any?(uniq_sentence, &(&1 === letter)) do
        acc ++ [letter]
      else
        acc ++ [""]
      end
    end)
    a_z == letters_used
  end
end
