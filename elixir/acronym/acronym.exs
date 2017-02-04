defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """

  @not_lower_case_regex ~r/[^A-Z]/u

  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(words) do
    words
    |> words_to_word_list
    |> upper_case_first_letter_of_words
    |> remove_lower_case_letters
  end

  defp upper_case_first_letter_of_words(word_list) do
    Enum.into(word_list, [], fn(word) -> first_char_to_uppercase(word) end)
  end

  defp first_char_to_uppercase(word) do
    code_points = String.codepoints(word)
    first = List.first(code_points)
    code_points
    |> List.replace_at(0, String.upcase(first))
    |> to_string
  end

  def remove_lower_case_letters(word_list) do
    Enum.into(word_list, [], fn(word) -> Regex.replace(@not_lower_case_regex, word, "") end)
    |> to_string
  end

  def words_to_word_list(words) do
    ~w(#{words})
  end
end