defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(""), do: {:ok, []}
  def of_rna(rna) do
    {head_codon, tail} = String.split_at(rna, 3)
    case of_codon(head_codon) do
      {:error, _} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> {:ok, []}
      {:ok, name} -> case of_rna(tail) do
        {:ok, rna_tail} -> {:ok, [name | rna_tail]}
        {:error, message} -> {:error, message}
      end
     end
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
    try do
      {:ok, cond do
        codon in ["UGU", "UGC"] -> "Cysteine"
        codon in ["UUA", "UUG"] -> "Leucine"
        codon in ["AUG"] -> "Methionine"
        codon in ["UUC", "UUU"] -> "Phenylalanine"
        codon in ["UCU", "UCC", "UCA", "UCG"] -> "Serine"
        codon in ["UGG"] -> "Tryptophan"
        codon in ["UAU", "UAC"] -> "Tyrosine"
        codon in ["UAA", "UAG", "UGA"] -> "STOP"
      end}
    rescue
      CondClauseError -> {:error, "invalid codon"}
    end
  end
end
