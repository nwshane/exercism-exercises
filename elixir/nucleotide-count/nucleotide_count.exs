defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    Enum.count(strand, &(&1 == nucleotide))
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    empty_histogram = %{
      ?A => 0,
      ?T => 0,
      ?C => 0,
      ?G => 0
    }

    Enum.reduce(strand, empty_histogram, fn
      x, hist when x in @nucleotides -> Map.update!(hist, x, &(&1 + 1))
      _x, hist -> hist
    end)
  end
end
