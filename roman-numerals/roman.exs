defmodule Roman do
  @roman %{
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  @roman_keys Map.keys(@roman) |> Enum.sort() |> Enum.reverse()
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) when is_integer(number) and number < 3999 and number > 0 do
    to_roman(@roman_keys, number, "")
  end

  defp to_roman(_, 0, result), do: result

  defp to_roman([max | _rest] = keys, number, result) when number >= max do
    to_roman(keys, number - max, result <> @roman[max])
  end

  defp to_roman([_max | rest] = _keys, number, result) do
    to_roman(rest, number, result)
  end
end
