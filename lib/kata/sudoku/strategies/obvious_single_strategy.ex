defmodule Kata.SudokuSolver.ObviousSingleStrategy do
  @moduledoc """
  If a cell has a single possible hint, then it's the value of the cell!

  Typical strategy to get hints for a cell: get all filled numbers in a row, column and block,
  and see what numbers are missing.
  """

  alias Kata.SudokuSolver.Puzzle

  def fill_in(puzzle) do
    puzzle
    |> get_hints()
    |> filter_hints()
    |> fill_in_cells(puzzle)
  end

  @all_numbers [1, 2, 3, 4, 5, 6, 7, 8, 9]

  defp get_hints(puzzle) do
    puzzle.cells
    |> Enum.filter(fn {_, value} -> is_nil(value) end)
    |> Enum.sort()
    |> Enum.map(fn {{i, j}, nil} ->
      row_values = Puzzle.get_row_values(puzzle, i)
      column_values = Puzzle.get_column_values(puzzle, j)
      block_values = Puzzle.get_block_values(puzzle, i, j)

      values = Enum.uniq(row_values ++ column_values ++ block_values)

      hints = @all_numbers -- values

      {{i, j}, hints}
    end)
  end

  defp filter_hints(hints) do
    Enum.reduce(hints, [], fn {position, values}, acc ->
      if length(values) == 1 do
        hint = {position, hd(values)}
        [hint | acc]
      else
        acc
      end
    end)
  end

  defp fill_in_cells(hints, puzzle) do
    Enum.reduce(hints, puzzle, fn {position, value}, p ->
      Puzzle.update_cell(p, position, value)
    end)
  end
end