defmodule RotationalCipher do
  require Logger

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  # @cypher_pattern "abcdefghijklmnopqrstuvwxyz"
  @upper ?A..?Z
  @lower ?a..?z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()

  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&rotate_letter(&1, shift))
    |> to_string
  end

  defp rotate_letter(char, shift) do
    cond do
      char in @upper -> rem(char - ?A + shift, 26) + ?A
      char in @lower -> rem(char - ?a + shift, 26) + ?a
      true -> char
    end
  end
end

IO.inspect(RotationalCipher.rotate("g", 5))
