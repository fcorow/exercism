defmodule PigLatin do
  defp _starts_with_vowel(word) do
    String.starts_with?(word, ["a", "e", "i", "o", "u", "xr", "yt"])
  end

  defp _split_by_group(word) do
    String.split(word, ~r{(sch)|(ch)|(qu)|(thr)|(th)|([^aeiou]qu)|[^aeiou]},
      parts: 2,
      include_captures: true,
      trim: true
    )
  end

  defp _translate_non_vowel(word) do
    [start, rest] = _split_by_group(word)
    rest <> start <> "ay"
  end

  def translate_word(word) do
    if _starts_with_vowel(word) do
      word <> "ay"
    else
      _translate_non_vowel(word)
    end
  end

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".
  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.
  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".
  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&translate_word(&1))
    |> Enum.join(" ")
  end
end
