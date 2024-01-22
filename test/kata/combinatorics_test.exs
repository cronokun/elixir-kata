defmodule Kata.CombinatoricsTest do
  use ExUnit.Case

  import Kata.Combinatorics

  test ".permutations/1 returns all permutations of given list elements" do
    assert permutations([1, 2, 3]) == [
             [1, 2, 3],
             [1, 3, 2],
             [2, 1, 3],
             [2, 3, 1],
             [3, 1, 2],
             [3, 2, 1]
           ]

    assert permutations([1, 2, 3, 4]) == [
             [1, 2, 3, 4],
             [1, 2, 4, 3],
             [1, 3, 2, 4],
             [1, 3, 4, 2],
             [1, 4, 2, 3],
             [1, 4, 3, 2],
             [2, 1, 3, 4],
             [2, 1, 4, 3],
             [2, 3, 1, 4],
             [2, 3, 4, 1],
             [2, 4, 1, 3],
             [2, 4, 3, 1],
             [3, 1, 2, 4],
             [3, 1, 4, 2],
             [3, 2, 1, 4],
             [3, 2, 4, 1],
             [3, 4, 1, 2],
             [3, 4, 2, 1],
             [4, 1, 2, 3],
             [4, 1, 3, 2],
             [4, 2, 1, 3],
             [4, 2, 3, 1],
             [4, 3, 1, 2],
             [4, 3, 2, 1]
           ]

    assert permutations([1, 2, 3, 4, 5]) == [
             [1, 2, 3, 4, 5],
             [1, 2, 3, 5, 4],
             [1, 2, 4, 3, 5],
             [1, 2, 4, 5, 3],
             [1, 2, 5, 3, 4],
             [1, 2, 5, 4, 3],
             [1, 3, 2, 4, 5],
             [1, 3, 2, 5, 4],
             [1, 3, 4, 2, 5],
             [1, 3, 4, 5, 2],
             [1, 3, 5, 2, 4],
             [1, 3, 5, 4, 2],
             [1, 4, 2, 3, 5],
             [1, 4, 2, 5, 3],
             [1, 4, 3, 2, 5],
             [1, 4, 3, 5, 2],
             [1, 4, 5, 2, 3],
             [1, 4, 5, 3, 2],
             [1, 5, 2, 3, 4],
             [1, 5, 2, 4, 3],
             [1, 5, 3, 2, 4],
             [1, 5, 3, 4, 2],
             [1, 5, 4, 2, 3],
             [1, 5, 4, 3, 2],
             [2, 1, 3, 4, 5],
             [2, 1, 3, 5, 4],
             [2, 1, 4, 3, 5],
             [2, 1, 4, 5, 3],
             [2, 1, 5, 3, 4],
             [2, 1, 5, 4, 3],
             [2, 3, 1, 4, 5],
             [2, 3, 1, 5, 4],
             [2, 3, 4, 1, 5],
             [2, 3, 4, 5, 1],
             [2, 3, 5, 1, 4],
             [2, 3, 5, 4, 1],
             [2, 4, 1, 3, 5],
             [2, 4, 1, 5, 3],
             [2, 4, 3, 1, 5],
             [2, 4, 3, 5, 1],
             [2, 4, 5, 1, 3],
             [2, 4, 5, 3, 1],
             [2, 5, 1, 3, 4],
             [2, 5, 1, 4, 3],
             [2, 5, 3, 1, 4],
             [2, 5, 3, 4, 1],
             [2, 5, 4, 1, 3],
             [2, 5, 4, 3, 1],
             [3, 1, 2, 4, 5],
             [3, 1, 2, 5, 4],
             [3, 1, 4, 2, 5],
             [3, 1, 4, 5, 2],
             [3, 1, 5, 2, 4],
             [3, 1, 5, 4, 2],
             [3, 2, 1, 4, 5],
             [3, 2, 1, 5, 4],
             [3, 2, 4, 1, 5],
             [3, 2, 4, 5, 1],
             [3, 2, 5, 1, 4],
             [3, 2, 5, 4, 1],
             [3, 4, 1, 2, 5],
             [3, 4, 1, 5, 2],
             [3, 4, 2, 1, 5],
             [3, 4, 2, 5, 1],
             [3, 4, 5, 1, 2],
             [3, 4, 5, 2, 1],
             [3, 5, 1, 2, 4],
             [3, 5, 1, 4, 2],
             [3, 5, 2, 1, 4],
             [3, 5, 2, 4, 1],
             [3, 5, 4, 1, 2],
             [3, 5, 4, 2, 1],
             [4, 1, 2, 3, 5],
             [4, 1, 2, 5, 3],
             [4, 1, 3, 2, 5],
             [4, 1, 3, 5, 2],
             [4, 1, 5, 2, 3],
             [4, 1, 5, 3, 2],
             [4, 2, 1, 3, 5],
             [4, 2, 1, 5, 3],
             [4, 2, 3, 1, 5],
             [4, 2, 3, 5, 1],
             [4, 2, 5, 1, 3],
             [4, 2, 5, 3, 1],
             [4, 3, 1, 2, 5],
             [4, 3, 1, 5, 2],
             [4, 3, 2, 1, 5],
             [4, 3, 2, 5, 1],
             [4, 3, 5, 1, 2],
             [4, 3, 5, 2, 1],
             [4, 5, 1, 2, 3],
             [4, 5, 1, 3, 2],
             [4, 5, 2, 1, 3],
             [4, 5, 2, 3, 1],
             [4, 5, 3, 1, 2],
             [4, 5, 3, 2, 1],
             [5, 1, 2, 3, 4],
             [5, 1, 2, 4, 3],
             [5, 1, 3, 2, 4],
             [5, 1, 3, 4, 2],
             [5, 1, 4, 2, 3],
             [5, 1, 4, 3, 2],
             [5, 2, 1, 3, 4],
             [5, 2, 1, 4, 3],
             [5, 2, 3, 1, 4],
             [5, 2, 3, 4, 1],
             [5, 2, 4, 1, 3],
             [5, 2, 4, 3, 1],
             [5, 3, 1, 2, 4],
             [5, 3, 1, 4, 2],
             [5, 3, 2, 1, 4],
             [5, 3, 2, 4, 1],
             [5, 3, 4, 1, 2],
             [5, 3, 4, 2, 1],
             [5, 4, 1, 2, 3],
             [5, 4, 1, 3, 2],
             [5, 4, 2, 1, 3],
             [5, 4, 2, 3, 1],
             [5, 4, 3, 1, 2],
             [5, 4, 3, 2, 1]
           ]
  end

  test ".uniq_perms/1 returns all uniq permutations of given list elements" do
    assert uniq_perms(~w[* .]) == [~w[* .], ~w[. *]]

    assert uniq_perms(~w[* . .]) == [
             ~w[* . .],
             ~w[. * .],
             ~w[. . *]
           ]

    assert uniq_perms(~w[* * . .]) == [
             ~w[* * . .],
             ~w[* . * .],
             ~w[* . . *],
             ~w[. * * .],
             ~w[. * . *],
             ~w[. . * *]
           ]

    assert uniq_perms(~w[* . . .]) == [
             ~w[* . . .],
             ~w[. * . .],
             ~w[. . * .],
             ~w[. . . *]
           ]

    assert uniq_perms(~w[* . . . . ]) == [
             ~w[* . . . .],
             ~w[. * . . .],
             ~w[. . * . .],
             ~w[. . . * .],
             ~w[. . . . *]
           ]

    assert uniq_perms(~w[* * . . . ]) ==
             [
               ~w[* * . . .],
               ~w[* . * . .],
               ~w[* . . * .],
               ~w[* . . . *],
               ~w[. * * . .],
               ~w[. * . * .],
               ~w[. * . . *],
               ~w[. . * * .],
               ~w[. . * . *],
               ~w[. . . * *]
             ]

    assert uniq_perms(~w[* * * . . ]) == [
             ~w[* * * . .],
             ~w[* * . * .],
             ~w[* * . . *],
             ~w[* . * * .],
             ~w[* . * . *],
             ~w[* . . * *],
             ~w[. * * * .],
             ~w[. * * . *],
             ~w[. * . * *],
             ~w[. . * * *]
           ]
  end

  test ".uniq_perms_count/1 returns number of all unique permutations of the list items" do
    assert count_variants_for_list_of(2) == [
             {0, 1},
             {1, 2},
             {2, 1}
           ]

    assert count_variants_for_list_of(3) == [
             {0, 1},
             {1, 3},
             {2, 3},
             {3, 1}
           ]

    assert count_variants_for_list_of(4) == [
             {0, 1},
             {1, 4},
             {2, 6},
             {3, 4},
             {4, 1}
           ]

    assert count_variants_for_list_of(5) == [
             {0, 1},
             {1, 5},
             {2, 10},
             {3, 10},
             {4, 5},
             {5, 1}
           ]

    assert count_variants_for_list_of(6) == [
             {0, 1},
             {1, 6},
             {2, 15},
             {3, 20},
             {4, 15},
             {5, 6},
             {6, 1}
           ]

    assert count_variants_for_list_of(7) == [
             {0, 1},
             {1, 7},
             {2, 21},
             {3, 35},
             {4, 35},
             {5, 21},
             {6, 7},
             {7, 1}
           ]

    assert count_variants_for_list_of(8) == [
             {0, 1},
             {1, 8},
             {2, 28},
             {3, 56},
             {4, 70},
             {5, 56},
             {6, 28},
             {7, 8},
             {8, 1}
           ]

    assert count_variants_for_list_of(9) == [
             {0, 1},
             {1, 9},
             {2, 36},
             {3, 84},
             {4, 126},
             {5, 126},
             {6, 84},
             {7, 36},
             {8, 9},
             {9, 1}
           ]

    assert count_variants_for_list_of(10) == [
             {0, 1},
             {1, 10},
             {2, 45},
             {3, 120},
             {4, 210},
             {5, 252},
             {6, 210},
             {7, 120},
             {8, 45},
             {9, 10},
             {10, 1}
           ]
  end

  defp count_variants_for_list_of(n) do
    for i <- 0..n, j = n - i do
      list = List.duplicate("*", i) ++ List.duplicate(".", j)
      {i, uniq_perms_count(list)}
    end
  end
end
