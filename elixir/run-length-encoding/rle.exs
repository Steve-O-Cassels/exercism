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
    split_to_constituent_letters(string)
    |> build_encoding
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    split_to_constituent_encodings(string)
    |> build_decoding
  end

  defp split_to_constituent_letters(string) do
    capture_repeated_chars = ~r{(.)\1*}
    Regex.scan(capture_repeated_chars, string)
  end

  defp split_to_constituent_encodings(string) do
    capture_encoded_letter = ~r/(\d+)([A-Z]{1})/
    Regex.scan(capture_encoded_letter,string)
  end

  def build_encoding(captures) when length(captures) > 0 do
     #Enum.map_join or...collectables to the rescue:
     Enum.into(captures, [], fn(capture) ->
       encode_characters(capture)
     end)
     |> to_string
  end
  def build_encoding([]) do
    ""
  end

  defp encode_characters([letters, letter]) do
    ~s(#{String.length(letters)}#{letter})
  end

  defp build_decoding(encodings) do
    Enum.into(encodings, [], fn(encoding) ->
      decode_characters(encoding)
    end)
    |> to_string
  end

  defp decode_characters([encoding, count, letter]) do
    String.duplicate(letter, String.to_integer(count))
  end
end
