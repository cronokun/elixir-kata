defmodule Kata.Combinatorics do
  @moduledoc ~S"""
  Simple conbinatorics functions: combinations, permutations, etc.

  # --- Permutations ---

  Given a list `[1, 2, 3]`, all permutations are:

    [
       [1, 2, 3],
       [1, 3, 2],
       [2, 1, 3],
       [2, 3, 1],
       [3, 1, 2],
       [3, 2, 1]
    ]

  Permutations for list [1,2,3,4]:

    [
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

  [
    [1, 2, 3] :: [[1,2,3,4], [1,2,4,3], [1,4,2,3], [4,1,2,3]]

    [1, 3, 2] :: [[1,3,2,4], [1,3,4,2], [1,4,3,2], [4,1,3,2]]

    [2, 1, 3] :: [[2,1,3,4], [2,1,4,3], [2,4,1,3], [4,2,1,3]]

    [2, 3, 1] :: [[2,3,1,4], [2,3,4,1], [2,3,3,1], [4,2,3,1]]

    [3, 1, 2] :: [[3,1,2,4], [3,1,4,2], [3,4,1,2], [4,3,1,2]]

    [3, 2, 1] :: [[3,2,1,4], [3,2,4,1], [3,4,2,1], [4,3,2,1]]
  ]

  Steps:

  1) x = 1, xs = [2, 3],
     ys = permutations(xs) = [[2,3], [3,2]]
     [x | ys]: [1 | [2, 3]] and [1 | [3,2]
     [[1,2,3], [1,3,2]]
  2) x = 2, xs = [1, 3]
     ys = [[1,3], [3,1]]
     [[2,1,3], [2,3,1]]
  3) x = 3, xs = [1,2],
     ys = [[1,2], [2,1]]
     [[3,1,2], [3,2,1]]
  4) total = [
       [1, 2, 3],
       [1, 3, 2],
       [2, 1, 3],
       [2, 3, 1],
       [3, 1, 2],
       [3, 2, 1]
     ]

  Steps for n = 4:

    [1,2,3,4]
  Number of permutations:

    | n  | variants |
    | 0  | 0        |
    | 1  | 1        |
    | 2  | 2        |
    | 3  | 6        |
    | 4  | 24       |
    | 5  | 120      |
    | 6  | 720      |
    | 7  | 5040     |
    | 8  | 40320    |
    | 9  | 362880   |
    | 10 | 3628800  |

    N = number_of_perm(n - 1) * n
  """

  @doc "Returns all permutations of list's elements"
  def permutations([]), do: [[]]

  def permutations(list) do
    for x <- list, ys <- permutations(list -- [x]), do: [x | ys]
  end

  @doc "Returns all unique permutation of list's elements"
  def uniq_perms(list) do
    list
    |> Enum.frequencies()
    |> Map.to_list()
    |> case do
      [{_a, _i}] -> [list]
      [{a, n}, {b, m}] -> do_uniq_pair_perm([], {a, n}, {b, m}, [])
      _ -> permutations(list) |> Enum.uniq()
    end
  end

  defp do_uniq_pair_perm(cur, {_a, 0}, {b, m}, acc) do
    r = Enum.reduce(1..m, cur, fn _i, acc -> [b | acc] end) |> Enum.reverse()
    Enum.reverse([r | acc])
  end

  defp do_uniq_pair_perm(cur, {a, n}, {_b, 0}, acc) do
    r = Enum.reduce(1..n, cur, fn _i, acc -> [a | acc] end) |> Enum.reverse()
    Enum.reverse([r | acc])
  end

  defp do_uniq_pair_perm(cur, {a, 1}, {b, 1}, acc) do
    v1 = [b, a | cur] |> Enum.reverse()
    v2 = [a, b | cur] |> Enum.reverse()
    Enum.reverse([v2, v1 | acc])
  end

  defp do_uniq_pair_perm(cur, {a, n}, {b, m}, acc) do
    v1 = do_uniq_pair_perm([a | cur], {a, n - 1}, {b, m}, acc)
    v2 = do_uniq_pair_perm([b | cur], {a, n}, {b, m - 1}, acc)
    v1 ++ v2
  end

  @doc "Returns number of all unique permutations of list's items"
  def uniq_perms_count(list) do
    list
    |> Enum.frequencies()
    |> Map.to_list()
    |> case do
      [{_a, _i}] -> 1
      [{_a, n}, {_b, m}] -> do_count_uniq_perms(n + m, n, %{}) |> elem(0)
      _ -> list |> permutations() |> length()
    end
  end

  defp do_count_uniq_perms(n, 1, memo), do: {n, Map.put_new(memo, {n, 1}, n)}
  defp do_count_uniq_perms(n, n, memo), do: {1, Map.put_new(memo, {n, n}, 1)}

  defp do_count_uniq_perms(n, m, memo) do
    {p1, memo} = get_or_calc_prev(memo, {n - 1, m}, &do_count_uniq_perms/3)
    {p2, memo} = get_or_calc_prev(memo, {n - 1, m - 1}, &do_count_uniq_perms/3)
    {p1 + p2, Map.put_new(memo, {n, m}, p1 + p2)}
  end

  defp get_or_calc_prev(memo, {n, m}, fun) do
    case memo[{n, m}] do
      nil -> fun.(n, m, memo)
      val -> {val, memo}
    end
  end
end
