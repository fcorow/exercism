defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    list = List.flatten(Regex.scan(~r/.../, rna))
    # IO.inspect(list)
    # test = Enum.find_index(list, &is_stop/1)
    # IO.inspect(test)
    # IO.inspect(Enum.map(list, &of_codon/1))

    results =
      {:ok,
       for(
         {_k, v} <-
           Enum.map(list, &of_codon/1)
           |> Enum.reject(fn x -> x == {:ok, "STOP"} end)
           |> Enum.slice(0, 3),
         do: v
       )}

    invalid_rna = Enum.any?(elem(results, 1), fn x -> x == "invalid codon" end)

    if invalid_rna do
      {:error, "invalid RNA"}
    else
      results
    end

    # Enum.filter(v, fn x -> x != "STOP" end)
    # IO.inspect(v)
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
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case codon do
      "UGU" -> {:ok, "Cysteine"}
      "UGC" -> {:ok, "Cysteine"}
      "UUA" -> {:ok, "Leucine"}
      "UUG" -> {:ok, "Leucine"}
      "AUG" -> {:ok, "Methionine"}
      "UUU" -> {:ok, "Phenylalanine"}
      "UUC" -> {:ok, "Phenylalanine"}
      "UCU" -> {:ok, "Serine"}
      "UCC" -> {:ok, "Serine"}
      "UCA" -> {:ok, "Serine"}
      "UCG" -> {:ok, "Serine"}
      "UGG" -> {:ok, "Tryptophan"}
      "UAU" -> {:ok, "Tyrosine"}
      "UAC" -> {:ok, "Tyrosine"}
      "UAA" -> {:ok, "STOP"}
      "UAG" -> {:ok, "STOP"}
      "UGA" -> {:ok, "STOP"}
      _ -> {:error, "invalid codon"}
    end
  end
end

IO.inspect(ProteinTranslation.of_rna("AUGUUUUGG"))
IO.inspect(ProteinTranslation.of_rna("AUGUUUUAA"))
IO.inspect(ProteinTranslation.of_rna("UUUROT"))
IO.inspect(ProteinTranslation.of_rna("CARROT"))
