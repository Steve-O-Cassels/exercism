defmodule Bob do
@moduledoc """
  Returns appropriate response for the rules in the readme.
"""

  @is_upper_case_word_regex ~r/\b[A-Z]+\b/

  @spec hey(String.t) :: String.t
  def hey(input) do
    cond do
      saying_nothing?(input) ->
        "Fine. Be that way!"
      yelling?(input) ->
        "Whoa, chill out!"
      questioning?(input) ->
        "Sure."
      true -> "Whatever."
    end
  end

  defp saying_nothing?(input) do
    input
    |> strip_white_space()
    |> nothing?()
  end

  defp yelling?(input) do
    Regex.match?(@is_upper_case_word_regex, input)
  end

  defp strip_white_space(input) do
    String.replace(input, " ", "")
  end

  defp questioning?(input) do
    String.ends_with?(input, "?")
  end

  defp nothing?(input) do
    String.length(input) == 0
  end

end
