defmodule Words do
  @moduledoc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  @remove_illegal_chars_regex ~r/,*:*[^A-Za-zö\s1-9-]*/
  @replace_underscores_regex ~r/\_/

  @doc """
  # split words on word boundary
  # recursively count words using Map.merge
  """
  @spec count(String.t) :: map
  def count(sentence) do
    all_the_words = Map.new()
    sentence
    |> replace_illegal_chars()
    |> normalize()
    |> sentence_to_word_array()
    |> create_count(all_the_words)
  end

  defp replace_illegal_chars(sentence) do
    sentence_no_underscores = Regex.replace(@replace_underscores_regex, sentence, " ")
    Regex.replace(@remove_illegal_chars_regex, sentence_no_underscores, "")
  end

  defp sentence_to_word_array(sentence) do
    String.split(sentence)
  end

  defp normalize(sentence) do
    String.downcase(sentence)
  end

  defp create_count(words, all_the_words) do
    count_all_words(all_the_words, words)
  end

  defp count_all_words(all_the_words, [head|tail]) do
    create_map([head])
    |> Map.merge(all_the_words, fn(key, value1, value2) ->
        value1 + value2
      end)
    |> count_all_words(tail)
  end

  defp count_all_words(all_the_words, []) do
    all_the_words
  end

  defp create_map(word) do
    Map.new(word, fn x -> {x, 1} end)
  end
end