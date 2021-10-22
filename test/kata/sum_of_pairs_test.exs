# test/kata/sum_of_pairs_test.exs
defmodule Kata.SumOfPairsTest do
  @moduledoc false

  use ExUnit.Case

  import Kata.SumOfPairs, only: [sum_pairs: 2, better_sum_pairs: 2]

  test ".sum_pairs/2" do
    assert sum_pairs([1, 4, 8, 7, 3, 15], 8) == {1, 7}
    assert sum_pairs([1, -2, 3, 0, -6, 1], -6) == {0, -6}
    assert sum_pairs([20, -13, 40], -7) == nil
    assert sum_pairs([1, 2, 3, 4, 1, 0], 2) == {1, 1}
    assert sum_pairs([10, 5, 2, 3, 7, 5], 10) == {3, 7}
    assert sum_pairs([4, -2, 3, 3, 4], 8) == {4, 4}
    assert sum_pairs([0, 2, 0], 0) == {0, 0}
    assert sum_pairs([5, 9, 13, -3], 10) == {13, -3}
    assert sum_pairs([12, 4, 5, 3, 8, 7, 5, -2], 10) == {3, 7}
  end

  test ".better_sum_pairs/2" do
    assert better_sum_pairs([1, 4, 8, 7, 3, 15], 8) == {1, 7}
    assert better_sum_pairs([1, -2, 3, 0, -6, 1], -6) == {0, -6}
    assert better_sum_pairs([20, -13, 40], -7) == nil
    assert better_sum_pairs([1, 2, 3, 4, 1, 0], 2) == {1, 1}
    assert better_sum_pairs([10, 5, 2, 3, 7, 5], 10) == {3, 7}
    assert better_sum_pairs([4, -2, 3, 3, 4], 8) == {4, 4}
    assert better_sum_pairs([0, 2, 0], 0) == {0, 0}
    assert better_sum_pairs([5, 9, 13, -3], 10) == {13, -3}
    assert better_sum_pairs([12, 4, 5, 3, 8, 7, 5, -2], 10) == {3, 7}
  end
end
