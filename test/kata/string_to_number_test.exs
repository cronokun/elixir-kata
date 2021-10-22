# test/kata/string_to_number_test.exs
defmodule Kata.StringToNumberTest do
  @moduledoc false

  use ExUnit.Case

  import Kata.StringToNumber, only: [convert: 1]

  test ".convert/1" do
    assert convert("0") == 0
    assert convert("1234") == 1234
    assert convert("605") == 605
    assert convert("1405") == 1405
    assert convert("-7") == -7
  end
end
