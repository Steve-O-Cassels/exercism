defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    acronym = []
    string
    |> ~W
    |> String.to_char_list()
    |> take_first_letter_from_word(acronym)
  end

  defp take_first_letter_from_word(acronym, head|tail) do
      acronym = [List.first(head)] ++ acronym
      take_first_letter_from_word(acronym, tail)
  end

  defp take_first_letter_from_word(acronym, []) do
      acronym
  end
end
