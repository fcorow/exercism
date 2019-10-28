defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """


  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    shiftedstring = Enum.map(String.to_charlist(text), &find_rotation(&1,shift))
    shiftedstring = List.to_string(shiftedstring)


  end

  defp is_uppercase(x) do
    x == String.upcase(x)
  end

  defp is_alpha(x) do
    String.match?(x, ~r/^[[:alpha:]]+$/)
  end

  defp find_rotation(char,offset) do

    need_tranform = is_alpha(List.to_string([char]))
    case need_tranform do
      true ->
        up = is_uppercase(List.to_string([char]))
        alpha = "abcdefghijklmnopqrstuvwxyz"
        char = String.downcase(List.to_string([char]))
        {index,_length} = :binary.match(alpha,List.to_string([char]))
        rotation = (index + offset)
        rotated_char =
        cond  do
          rotation < 26 -> String.at(alpha, index+offset)
          rotation >= 26  -> String.at(alpha, (index+offset) - 26)
        end
        case up do
          true -> rotated_char = String.upcase(List.to_string([rotated_char]))
          _ -> rotated_char
        end
      _ -> char
    end

  end




end

