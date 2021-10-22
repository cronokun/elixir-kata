defmodule Kata.Divisible13Test do
  @moduledoc false

  use ExUnit.Case

  import Kata.Divisible13, only: [thirt: 1]

  test ".thirt" do
    assert thirt(8529) == 79
    assert thirt(85_299_258) == 31
    assert thirt(5634) == 57
    assert thirt(1_111_111_111) == 71
    assert thirt(987_654_321) == 30
  end
end
