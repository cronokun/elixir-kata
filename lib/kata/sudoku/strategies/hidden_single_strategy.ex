defmodule Kata.SudokuSolver.HiddenSingleStrategy do
  @moduledoc """
  Check hints for a row, column or block to see if there is only one cell with a specific digit.

  Digit 1 is present in only cell (a), so even if it has other hints, we can fill it with 1.

  +-------+    +-----------------------+        +-----------------------+
  | . . a |    | . . .   . . .   1 . . |        | . . .   . . .   ╭   ╮ |
  | . 2 6 |    | . . .   . . .   . . . |        | . . .   . . .     1   |
  | . . 5 |    | 7 8 9   7 8 9   7 8 . |        | 7 8 9   7 8 9   ╰   ╯ |
  +-------+    |                       |        |                       |
      |        | . . 3   ╭   ╮   ╭   ╮ |        | . . 3   ╭   ╮   ╭   ╮ |
      |        | 4 . .     2       6   |  ---▶︎  | 4 . .     2       6   |
      +------> | 7 8 .   ╰   ╯   ╰   ╯ |        | 7 8 .   ╰   ╯   ╰   ╯ |
      (hints)  |                       |        |                       |
               | . . 3   . . 3   ╭   ╮ |        | . . 3   . . 3   ╭   ╮ |
               | 4 . .   4 . .     5   |        | 4 . .   4 . .     5   |
               | . . 9   . . 9   ╰   ╯ |        | . . 9   . . 9   ╰   ╯ |
               +-----------------------+        +-----------------------+
  """

  alias Kata.SudokuSolver.Puzzle

  def run(puzzle) do
    puzzle
    |> filter_hints()
    |> fill_in_cells(puzzle)
  end

  defp filter_hints(puzzle) do
    puzzle.hints
    |> Enum.group_by(fn {{i, j}, _values} -> Puzzle.block_number(i, j) end)
    |> Map.values()
    |> Enum.reduce([], fn hints, acc -> acc ++ get_hidden_singles(hints) end)
  end

  defp get_hidden_singles(hints) do
    hints
    |> Enum.reduce([], fn {_, values}, acc -> acc ++ values end)
    |> Enum.frequencies()
    |> Enum.reduce([], fn {value, count}, acc ->
      if count == 1, do: [value | acc], else: acc
    end)
    |> Enum.map(fn value ->
      {position, _} = Enum.find(hints, fn {_, values} -> value in values end)
      {position, value}
    end)
  end

  defp fill_in_cells(hints, puzzle) do
    Enum.reduce(hints, puzzle, fn {position, value}, p ->
      Puzzle.update_cell(p, position, value)
    end)
  end
end
