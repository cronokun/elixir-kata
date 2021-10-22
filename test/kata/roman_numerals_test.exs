defmodule Kata.RomanNumeralsTest do
  @moduledoc false

  use ExUnit.Case

  import Kata.RomanNumerals, only: [to_roman: 1]

  describe ".to_roman/1" do
    test "returns string representing roman numeral" do
      assert to_roman(3) == "III"
      assert to_roman(4) == "IV"
      assert to_roman(8) == "VIII"
      assert to_roman(9) == "IX"
      assert to_roman(12) == "XII"
      assert to_roman(24) == "XXIV"
      assert to_roman(39) == "XXXIX"
      assert to_roman(160) == "CLX"
      assert to_roman(207) == "CCVII"
      assert to_roman(246) == "CCXLVI"
      assert to_roman(789) == "DCCLXXXIX"
      assert to_roman(1_009) == "MIX"
      assert to_roman(1_066) == "MLXVI"
      assert to_roman(1_776) == "MDCCLXXVI"
      assert to_roman(1_918) == "MCMXVIII"
      assert to_roman(1_954) == "MCMLIV"
      assert to_roman(2_014) == "MMXIV"
      assert to_roman(2_421) == "MMCDXXI"
      assert to_roman(3_999) == "MMMCMXCIX"
    end
  end
end
