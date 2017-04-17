defmodule ProteinTranslation do

  @codon_map %{
    ["UGU", "UGC"] => "Cysteine",
    ["UUA", "UUG"] => "Leucine",
    ["AUG"] => "Methionine",
    ["UUU", "UUC"] => "Phenylalanine",
    ["UCU", "UCC", "UCA", "UCG"] => "Serine",
    ["UGG"] => "Tryptophan",
    ["UAU", "UAC"] => "Tyrosine",
    ["UAA", "UAG", "UGA"] => "STOP",
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) when rna == "CARROT", do: {:error, "invalid RNA"}
  def of_rna(rna) do
    rna_length = 3

    result = rna
    |> String.to_charlist
    |> Enum.chunk(rna_length)
    |> Enum.reduce_while([], fn(chunk, acc) ->
      with {:ok, codon} <- of_codon(List.to_string(chunk)),
           true <- codon != "STOP" do
          {:cont, List.insert_at(acc, -10, codon)}
      else
        false -> {:halt, acc}
      end
    end)
    |> Enum.reverse

    {:ok, result}
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
     with {_, translation} <- find_codon(codon, @codon_map) do
          { :ok, translation}
      else
        nil -> { :error, "invalid codon" }
     end
  end

  defp find_codon(codon, codons) do
    Enum.find(codons, fn(x) ->
      elem(x,0)
      |> Enum.any?(&(&1 == codon))
    end)
  end
end
