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
    string
    |> String.to_charlist
    |> Enum.chunk_by(&(&1))
    |> encode_letter_chunks
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> split_to_constituent_encodings
    |> build_decoding
    |> to_string
  end

  defp split_to_constituent_encodings(string) do
   capture_encoded_letter = ~r/(\d+)([A-Z]{1})/
   Regex.scan(capture_encoded_letter,string)
  end

  defp encode_letter_chunks(letter_chunks) do
    letter_chunks
    |> Enum.reduce("", fn(chunk, acc) ->
       acc <> ~s(#{length(chunk)}#{<<hd(chunk)>>})
     end)
  end

  defp build_decoding(encodings) do
    Enum.into(encodings, [], fn([_, count, letter]) ->
      String.duplicate(letter, String.to_integer(count))
    end)
  end
end
