defmodule Kata.SudokuSolver.Solver do
  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.Utils
  alias Kata.SudokuSolver.Validator
  alias Kata.SudokuSolver.LastFreeCellStrategy
  alias Kata.SudokuSolver.LastRemainingCellStrategy
  alias Kata.SudokuSolver.LastPossibleNumberStrategy
  alias Kata.SudokuSolver.ObviousSingleStrategy
  alias Kata.SudokuSolver.HiddenSingleStrategy
  alias Kata.SudokuSolver.PointingPairStrategy

  @moduledoc """
  # Strategies to Solve


  ## Obvious triplets

  Similar to "Obvious paris" but for triplets.

  +-------+
  | 3 7 a |  Cells (d), (e), and (f) has numbers [1,5,8]; that means other cells can't have them,
  | 9 b c |  so we remove them from hints.
  | d e f |
  +-------+  Fothermore, as we can see, (a) and (c) is "Obious pair", so we cat reduce further.

  +-----------------------+     +-----------------------+     +-----------------------+
  | ╭   ╮   ╭   ╮   . 2 . |     | ╭   ╮   ╭   ╮   . 2 . |     | ╭   ╮   ╭   ╮   . 2 . |
  |   3       7     4 5 . |     |   3       7     4 . . |     |   3       7     4 . . |
  | ╰   ╯   ╰   ╯   . 8 . |     | ╰   ╯   ╰   ╯   . . . |     | ╰   ╯   ╰   ╯   . . . |
  |                       |     |                       |     |                       |
  | ╭   ╮   1 2 .   . 2 . |     | ╭   ╮   . 2 .   . 2 . |     | ╭   ╮   ╭   ╮   . 2 . |
  |   9     4 . 6   4 5 . | --▶︎ |   9     4 . 6   4 . . | --▶︎ |   9       6     4 . . |
  | ╰   ╯   . 8 .   . 8 . |     | ╰   ╯   . . .   . . . |     | ╰   ╯   ╰   ╯   . . . |
  |                       |     |                       |     |                       |
  | 1 . .   1 . .   . . . |     | 1 . .   1 . .   . . . |     | 1 . .   1 . .   . . . |
  | . 5 .   . . .   . 5 . |     | . 5 .   . . .   . 5 . |     | . 5 .   . . .   . 5 . |
  | . . .   . 8 .   . 8 . |     | . . .   . 8 .   . 8 . |     | . . .   . 8 .   . 8 . |
  +-----------------------+     +-----------------------+     +-----------------------+


  ## Hidden pairs

  If you can find two cells within a row, column, or block where two Hints appear nowhere outside
  these cells, these two Hints must be placed in the two cells. All other Hints can be eliminated
  from these two cells.


  Only two cell's hints has digits 2 and 6 -- cells (a) and (b). So we can remove
  other hints from these cells:

  +-------+    +-----------------------+        +-----------------------+
  | . 1 . |    | . . 3   ╭   ╮   . . 3 |        | . . 3   ╭   ╮   . . 3 |
  | a . . |    | 4 . .     1     4 . . |        | 4 . .     1     4 . . |
  | b 5 . |    | 7 8 9   ╰   ╯   7 8 . |        | 7 8 9   ╰   ╯   7 8 . |
  +-------+    |                       |        |                       |
      |        | . 2 3   . . 3   . . 3 |        | . 2 .   . . 3   . . 3 |
      |        | 4 . 6   4 . .   4 . . |  ---▶︎  | . . 6   4 . .   4 . . |
      +------> | 7 8 .   7 8 .   7 8 . |        | . . .   7 8 .   7 8 . |
      (hints)  |                       |        |                       |
               | . 2 3   ╭   ╮   . . 3 |        | . 2 .   ╭   ╮   . . 3 |
               | 4 . 6     5     4 . . |        | . . 6     5     4 . . |
               | . 8 9   ╰   ╯   . 8 . |        | . . .   ╰   ╯   . 8 . |
               +-----------------------+        +-----------------------+

  ## Pointing pairs/triplets

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
  | ░ 1 . | . . . | . . . |     b)(| 4 5 .   . 5 6     3   |
  | ░ . . | . . . | 2 8 4 |        | 7 . .   7 . .   ╰   ╯ |
  +-------+-------+-------+        +-----------------------+
  """

  @all_strategies [
    LastFreeCellStrategy,
    LastRemainingCellStrategy,
    LastPossibleNumberStrategy,
    ObviousSingleStrategy,
    HiddenSingleStrategy,
    PointingPairStrategy
  ]

  def solve!(puzzle) do
    IO.puts("\n> SOLVING PUZZLE...")

    case do_solve(puzzle, @all_strategies) do
      {:ok, puzzle} ->
        IO.puts("DONE\n")
        puzzle

      {:error, unsolved_puzzle} ->
        IO.puts("FAILED!\n")
        Utils.print(puzzle, label: "before:\n")
        Utils.print(unsolved_puzzle, hints: true, label: "after:\n")
        raise "Can't solve the puzzle"
    end
  end

  defp do_solve(puzzle, []) do
    {:error, puzzle}
  end

  defp do_solve(puzzle, [strategy | rest]) do
    case run(puzzle, strategy) do
      {:done, solved_puzzle} ->
        check_puzzle!(solved_puzzle)

      {:cont, updated_puzzle} ->
        do_solve(updated_puzzle, @all_strategies)

      {:halt, puzzle} ->
        do_solve(puzzle, rest)
    end
  end

  defp run(puzzle, strategy) do
    updated_puzzle = strategy.run(puzzle)

    log_changes(strategy, puzzle, updated_puzzle)

    cond do
      puzzle_solved?(updated_puzzle) ->
        {:done, updated_puzzle}

      puzzle_changed?(puzzle, updated_puzzle) ->
        {:cont, updated_puzzle}

      true ->
        {:halt, puzzle}
    end
  end

  defp log_changes(strategy, a, b) do
    module = strategy |> inspect() |> String.split(".") |> List.last()
    ca = Puzzle.blank_cells_count(a)
    cb = Puzzle.blank_cells_count(b)
    ha = Puzzle.hints_count(a)
    hb = Puzzle.hints_count(b)

    IO.puts("[#{module}]  cells #{ca} -> #{cb}  •  hints #{ha} -> #{hb}")
  end

  defp puzzle_changed?(a, b), do: cells_filled?(a, b) or hints_changed?(a, b)

  defp puzzle_solved?(puzzle), do: Puzzle.blank_cells_count(puzzle) == 0

  defp cells_filled?(a, b), do: Puzzle.blank_cells_count(a) != Puzzle.blank_cells_count(b)

  defp hints_changed?(a, b), do: Puzzle.hints_count(a) != Puzzle.hints_count(b)

  defp check_puzzle!(puzzle) do
    if Validator.solved?(puzzle), do: {:ok, puzzle}, else: raise("OH NOES!")
  end
end
