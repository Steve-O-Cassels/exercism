defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    cond do
      encode_string?(string) ->
        encode_string(string)
      true ->
        return_empty_string
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do

  end

  defp encode_string?(string) do
    String.strip(string)
    |> String.valid_character?()
  end

  defp return_empty_string() do
    ""
  end

  defp encode_string(string) do
    code_points = String.codepoints(word)
    first = List.first(code_points)

    count_letter(code_points, first, 1, 0)
  end

  defp count_letter([head|tail], letter, count, current_index) do
    cond do
      head = letter ->
        count_letter(tail, letter, count + 1, current_index + 1)
      true ->
        #
    end


  end
end
