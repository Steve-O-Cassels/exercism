defmodule Bob do
@moduledoc """
  Returns appropriate response for the rules in the readme.
"""

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
    |> strip_char(" ")
    |> nothing?()
  end

  defp yelling?(input) do
    cleaned =
      input
      |> strip_char(", ")

    is_all_number = fn(x) -> x =~ ~r/^\d+$/ end
    is_upper_case = fn(x) -> String.upcase(x) == x end

    !is_all_number.(cleaned) &&
    !questioning?(cleaned) &&
    is_upper_case.(cleaned)
  end

  defp strip_char(input, char) do
    String.replace(input, char, "")
  end

  defp questioning?(input) do
    String.ends_with?(input, "?")
  end

  defp nothing?(input) do
    String.length(input) == 0
  end
end
