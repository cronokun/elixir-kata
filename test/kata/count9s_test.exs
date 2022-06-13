defmodule Kata.Count9sTest do
  use ExUnit.Case

  import Kata.Count9s

  test "returns numer of 9s" do
    assert number9(8) == 0
    assert number9(9) == 1

    # tens
    assert number9(19) == 2
    assert number9(29) == 3
    assert number9(89) == 9
    assert number9(90) == 10
    assert number9(95) == 15
    assert number9(98) == 18
    assert number9(99) == 20

    # hundreds
    assert number9(100) == 20
    assert number9(109) == 21
    assert number9(119) == 22
    assert number9(198) == 38
    assert number9(199) == 40

    assert number9(489) == 89
    assert number9(498) == 98
    assert number9(499) == 100
    assert number9(500) == 100

    assert number9(900) == 181
    assert number9(901) == 182
    assert number9(902) == 183
    assert number9(903) == 184
    assert number9(904) == 185
    assert number9(905) == 186
    assert number9(906) == 187
    assert number9(907) == 188
    assert number9(908) == 189
    assert number9(909) == 191

    assert number9(910) == 192
    assert number9(911) == 193
    assert number9(912) == 194
    assert number9(913) == 195
    assert number9(914) == 196
    assert number9(915) == 197
    assert number9(916) == 198
    assert number9(917) == 199
    assert number9(918) == 200
    assert number9(919) == 202

    assert number9(920) == 203
    assert number9(930) == 214
    assert number9(932) == 216
    assert number9(940) == 225

    assert number9(989) == 279
    assert number9(990) == 281
    assert number9(998) == 297
    assert number9(999) == 300

    # southands
    assert number9(10_000) == 4_000
    assert number9(10_100) == 4_020
    assert number9(19_979) == 7_948

    # from codewars
    assert number9(565_754) == 275_645
    assert number9(10_000_000_000) == 10_000_000_000
  end
end
