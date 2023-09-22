defmodule Kata.SudokuSolver.PointingPairStrategy do
  @moduledoc """
  If a pair/triplet of numbers presented in Hints is in the same row or column, that means these
  number can't be present anywhere in the same row/column and can be removed from hints.

  In 1st block number 4 appears only in column 1, so we can remove number 1 from all Hints in
  column 1.

  +-------+-------+-------+        +-----------------------+
  | a . 9 | . 7 . | . . . |        | . 2 .   . . .   ╭   ╮ |
  | ░ 8 . | 4 . . | . . . |    (a) | 4 5 .   . 5 6     9   |
  | b . 3 | . . . | . 2 8 |        | . . .   . . .   ╰   ╯ |
  +-------+-------+-------+        |                       |
  | 1 . . | . . . | 6 7 . |        | . 2 .   ╭   ╮   1 2 . |
  | ░ 2 . | . 1 3 | . 4 . |  ---▶︎  | . 5 .     8     . 5 6 |
  | ░ 4 . | . . 7 | 8 . . |        | 7 . .   ╰   ╯   7 . . |
  +-------+-------+-------+        |                       |
  | 6 . . | . 3 . | . . . |        | . . .   . . .   ╭   ╮ |
  | ░ 1 . | . . . | . . . |    (b) | 4 5 .   . 5 6     3   |
  | ░ . . | . . . | 2 8 4 |        | 7 . .   7 . .   ╰   ╯ |
  +-------+-------+-------+        +-----------------------+
  """

  alias Kata.SudokuSolver.Puzzle

  def run(puzzle) do
    puzzle
    |> get_rejected_hints()
    |> update_hints(puzzle)
  end

  defp get_rejected_hints(puzzle) do
    hints = for n <- 1..9, do: {n, rejected_cell_hints(puzzle.hints, n)}
    Enum.reject(hints, fn {_, cells} -> cells == [] end)
  end

  defp rejected_cell_hints(hints, n) do
    all_cells =
      hints
      |> Enum.sort()
      |> Enum.reduce([], fn {position, vs}, acc -> if n in vs, do: [position | acc], else: acc end)

    all_pairs =
      all_cells
      |> Enum.group_by(fn {i, j} -> Puzzle.block_number(i, j) end)
      |> Map.values()
      |> Enum.filter(&(length(&1) == 2))

    Enum.reduce(all_pairs, [], fn list, acc ->
      case detect_a_pair(list) do
        {:ok, :row, ii} ->
          deleted_cells = Enum.filter(all_cells -- list, fn {i, _} -> i == ii end)
          acc ++ deleted_cells

        {:ok, :col, jj} ->
          deleted_cells = Enum.filter(all_cells -- list, fn {_, j} -> j == jj end)
          acc ++ deleted_cells

        nil ->
          acc
      end
    end)
  end

  defp detect_a_pair([{i, _}, {i, _}]), do: {:ok, :row, i}
  defp detect_a_pair([{_, j}, {_, j}]), do: {:ok, :col, j}
  defp detect_a_pair(_), do: nil

  defp update_hints(rejected_hints, puzzle) do
    flatten_hitns = for {n, cells} <- rejected_hints, cell <- cells, do: {cell, n}

    Enum.reduce(flatten_hitns, puzzle, fn {position, n}, p ->
      update_in(p, [Access.key!(:hints), position], &List.delete(&1, n))
    end)
  end
end
