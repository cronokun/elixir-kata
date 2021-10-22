defmodule Kata.StringToNumber do
  @moduledoc """
  Convert string representing a number into integer.
  """

  @digits %{
    "0" => 0,
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9
  }

  @spec convert(String.t()) :: integer
  def convert(str) do
    str
    |> String.graphemes()
    |> Enum.map(fn d -> @digits[d] end)
    |> undigits_with_sign()
  end

  defp undigits_with_sign([nil | digits]), do: -undigits_with_sign(digits)
  defp undigits_with_sign(digits), do: Integer.undigits(digits)
end
