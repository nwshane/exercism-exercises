defmodule RotationalCipher do
  defp wrapLetter(letter, base) do
    rem(letter - base, 26) + base
  end

  defp shiftLetter(char, amount) do
    cond do
      char in ?A..?Z -> wrapLetter(char + amount, ?A)
      char in ?a..?z -> wrapLetter(char + amount, ?a)
      true -> char
    end
  end

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(fn char -> shiftLetter(char, rem(shift, 26)) end)
    |> to_string
  end
end
