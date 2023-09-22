defmodule Kata.SudokuSolver.ObviousSingleStrategy do
  @moduledoc """
  If a cell has a single possible hint, then it's the value of the cell!

  Typical strategy to get hints for a cell: get all filled numbers in a row, column and block,
  and see what numbers are missing.
  """

  alias Kata.SudokuSolver.Puzzle

  def run(puzzle) do
    puzzle
    |> filter_hints()
    |> fill_in_cells(puzzle)
  end

  defp filter_hints(puzzle) do
    Enum.reduce(puzzle.hints, [], fn {position, values}, acc ->
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
