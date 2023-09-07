defmodule Kata.SudokuSolver.LastRemainingCellStrategy do
  @moduledoc """
  Numbers should not repeat within 3×3 block, vertical column and horizontal row. If a number
  can't be filled in any other cell except one, fill it in!

  Example:

  | . . ░ | . . . | . .
  | . . ░ | . . . | . .
  +-------+-------+----
  | . . 8 | . . . | . .
  | . . ░ | . . . | . .
  | . . ░ | . . . | . .
  +-------+-------+----
  |░░░░░░░|░░░8░░░|░░░░
  | * 6 ░ | . . . | . .
  | 9 1 ░ | . . . | . .
  +-------+-------+----

  For block (7), horizontal row (7), and vertical column (3) already have number 8,
  so the only remaining cell that can have it is cell (8,1).
  """

  alias Kata.SudokuSolver.Puzzle

  def run(puzzle) do
    puzzle
    |> Puzzle.blocks()
    |> Map.values()
    |> Enum.flat_map(&last_remaining_cells_for(&1, puzzle))
    |> Enum.reduce(puzzle, fn {position, value}, p -> Puzzle.update_cell(p, position, value) end)
  end

  defp last_remaining_cells_for(cells, puzzle) do
    {empty, filled} = Enum.split_with(cells, fn {_, v} -> is_nil(v) end)
    remaining = get_remaining_numbers(filled)
    filter_last_remaining_cells(remaining, empty, puzzle)
  end

  defp get_remaining_numbers(cells) do
    Enum.reduce(cells, Range.to_list(1..9), fn {_, v}, ns -> List.delete(ns, v) end)
  end

  defp filter_last_remaining_cells(remaining_numbers, empty_cells, puzzle) do
    Enum.reduce(remaining_numbers, [], fn n, acc ->
      cells = get_possible_cells_for(n, empty_cells, puzzle)

      if length(cells) == 1 do
        position = cells |> hd() |> elem(0)
        [{position, n} | acc]
      else
        acc
      end
    end)
  end

  defp get_possible_cells_for(n, cells, puzzle) do
    Enum.reject(cells, fn {{i, j}, nil} ->
      n in Puzzle.get_row_values(puzzle, i) or n in Puzzle.get_column_values(puzzle, j)
    end)
  end
end
