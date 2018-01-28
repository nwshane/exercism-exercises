defmodule PigLatin do
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

  @large_vowels ["yt", "xr"]
  @vowels ["a", "e", "i", "o", "u"] ++ @large_vowels
  @large_consonants ["ch", "qu", "pl", "squ", "thr", "th", "sch", "str"]
  @large_sounds @large_vowels ++ @large_consonants

  def get_first_consonants(""), do: ""
  def get_first_consonants(string) do
    {head, tail} = String.split_at(string, 1)
    cond do
      head in @vowels -> ""
      true -> head <> get_first_consonants(tail)
    end
  end

  def get_first_sound(string) do
    first_three = String.slice(string, 0, 3)
    first_two = String.slice(string, 0, 2)
    first = String.first string

    cond do
      first_three in @large_sounds -> first_three
      first_two in @large_sounds -> first_two
      first in @vowels -> first
      true -> get_first_consonants(string)
    end
  end

  def append_suffix(phrase) do
    phrase <> "ay"
  end

  def get_word_core(phrase) do
    String.slice(phrase, String.length(get_first_sound(phrase))..-1)
  end

  def rotate_first_sound(phrase) do
    get_word_core(phrase) <> get_first_sound(phrase)
  end

  def start_with_vowel(phrase) do
    get_first_sound(phrase) in @vowels
  end

  def translate_word(word) do
    cond do
      start_with_vowel(word) -> word |> append_suffix
      true -> word |> rotate_first_sound |> append_suffix
    end
  end

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end
end
