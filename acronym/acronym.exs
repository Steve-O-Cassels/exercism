defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """

  @match_words_title_and_lower ~r/[A-Z][a-z]*|[a-z]+/

  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(words) do
    words
    |> split_on_title_case
    |> words_to_word_list
    |> word_list_to_char_list
    |> pick_first_letter
    |> char_list_to_string
    |> String.upcase
  end

  defp split_on_title_case(words) do
    String.split(words, @match_words_title_and_lower)
  end

  defp words_to_word_list(words) do
    ~w(#{words})
  end

  defp word_list_to_char_list(word_list) do
    Enum.into(word_list, [], fn w -> String.to_char_list(w) end)
    #or
    # Atom.to_char_list(:w)
  end

  defp pick_first_letter(char_list) do
    Enum.into(char_list, [], fn c -> List.first(c) end)
  end

  defp char_list_to_string(char_list) do
    ~s(#{char_list})
    # or
    # to_string char_list
  end

end
