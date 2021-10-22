defmodule Kata.RomanNumerals do
  @moduledoc """
  Convert numbers between arabian and roman numerals.

  Roman numerals:
  - I => 1,
  - V => 5,
  - X => 10,
  - L => 50,
  - C => 100,
  - D => 500,
  - M => 1_000.

  Subtractive notation is used for:
  - IV => 4,
  - IX => 9,
  - XL => 40,
  - XC => 90,
  - CD => 400,
  - CM => 900.

  So, MMXXI is a 2021.
  """

  @typedoc "List of I | V | X | L | C | D | M "
  @type roman_numeral :: String.t()

  import String, only: [duplicate: 2, replace: 3]

  @doc """
  Naive implementation with string replacement. Surprisingly works pretty fast. 
  """
  @spec to_roman(pos_integer) :: roman_numeral
  def to_roman(n) do
    duplicate("I", n)
    |> replace("IIIII", "V")
    |> replace("VV", "X")
    |> replace("XXXXX", "L")
    |> replace("LL", "C")
    |> replace("CCCCC", "D")
    |> replace("DD", "M")
    |> replace("VIIII", "IX")
    |> replace("IIII", "IV")
    |> replace("LXXXX", "XC")
    |> replace("XXXX", "XL")
    |> replace("DCCCC", "CM")
    |> replace("CCCC", "CD")
  end
end
