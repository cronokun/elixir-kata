defmodule Kata.SudokuSolver.Solver do
  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.Utils
  alias Kata.SudokuSolver.Validator
  alias Kata.SudokuSolver.LastFreeCellStrategy
  alias Kata.SudokuSolver.LastRemainingCellStrategy
  alias Kata.SudokuSolver.LastPossibleNumberStrategy
  alias Kata.SudokuSolver.ObviousSingleStrategy
  alias Kata.SudokuSolver.HiddenSingleStrategy

  @moduledoc """
  # Strategies to Solve

  ## Obvious pairs

  If a block's hints has a two cells with the same pair of numbers, that means those numbers
  can't be on any other cells and you can remove them from other hints.

  Example:

            +-------+                          +-------+
  [6,7,9] ->| a 8 5 |                          | 6 8 5 |
    [7,9] ->| b 3 c |<- [4,7,9]  ===>  [7,9] ->| b 3 4 |
            | 2 1 d |<- [7,9]                  | 2 1 d |<- [7,9]
            +-------+                          +-------+

  All four remaining cells has 7 and 9 as hints; but only cells (b) and (d) has only them.
  If (b) is 7 then (d) is 9, or other way around - (b) is 9 and (d) is 7. That means that
  cell (a) and (c) can't be 7 or 9, so we can remove these numbers from cell's hints.


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
    HiddenSingleStrategy
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
        Utils.print(unsolved_puzzle, label: "after:\n")
        raise "Can't solve the puzzle"
    end
  end

  defp do_solve(puzzle, []) do
    {:error, puzzle}
  end

  defp do_solve(puzzle, [strategy | rest]) do
    case fill_in_with(puzzle, strategy) do
      {:done, solved_puzzle} ->
        check_puzzle!(solved_puzzle)

      {:cont, updated_puzzle} ->
        do_solve(updated_puzzle, @all_strategies)

      {:halt, puzzle} ->
        do_solve(puzzle, rest)
    end
  end

  defp fill_in_with(puzzle, strategy) do
    updated_puzzle = strategy.run(puzzle)
    count_before = Puzzle.blank_cells_count(puzzle)
    count_after = Puzzle.blank_cells_count(updated_puzzle)

    log_changes(strategy, count_before, count_after)

    cond do
      count_after == 0 ->
        {:done, updated_puzzle}

      count_after == count_before ->
        {:halt, puzzle}

      true ->
        {:cont, updated_puzzle}
    end
  end

  defp log_changes(strategy, count_before, count_after) do
    module = strategy |> inspect() |> String.split(".") |> List.last()
    IO.puts("[#{module}] #{count_before} -> #{count_after} blank cells left")
  end

  defp check_puzzle!(puzzle) do
    if Validator.solved?(puzzle), do: {:ok, puzzle}, else: raise("OH NOES!")
  end
end
