defmodule Kata.DescendingOrderTest do
  @moduledoc false

  use ExUnit.Case

  import Kata.DescendingOrder, only: [rearrange: 1]

  test ".rearrange" do
    assert rearrange(0) == 0
    assert rearrange(123_456_789) == 987_654_321
    assert rearrange(567_821) == 876_521
    assert rearrange(55672) == 76552
    assert rearrange(1_231_293_922) == 9_933_222_211
  end
end
