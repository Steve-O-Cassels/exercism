defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """

  @dna_rna_map %{
    "G" => "C",
    "C" => "G",
    "T" => "A",
    "A" => "U"
  }
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.reduce(dna, [], fn(x, acc) ->
      nucleotide = IO.chardata_to_string([x])
      case Map.has_key?(@dna_rna_map, nucleotide) do
        true ->
           rna = @dna_rna_map[nucleotide] |> String.to_charlist
           acc ++ rna
        _ -> acc
      end
    end)
  end
end
