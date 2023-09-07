defmodule Kata.SudokuSolver.LastPossibleNumberStrategy do
  @moduledoc """
  Look what numer is missing in the interconection of row, column and block.

  Example:

  2░4░6░| . . . | . . .
  *░░░░░|░3░░░6░|░░░7░4
  3░7░░░| . . . | . . .
  ------+-------+------
  ░ . . | . . . | . . .
  1 . . | . . . | . . .
  ░ . . | . . . | . . .
  ------+-------+------
  ░ . . | . . . | . . .
  8 . . | . . . | . . .
  9 . . | . . . | . . .

  For cell (2,1) number 2, 4, 6 already filled in the block; 3 and 7 - in the
  row, and 1, 2 and 9 - in the columns. The only number remaining is 5.
  """

  alias Kata.SudokuSolver.Puzzle

  def run(puzzle) do
    puzzle
    |> blank_cells()
    |> get_last_possible_numbers(puzzle)
    |> Enum.reduce(puzzle, fn {position, value}, p -> Puzzle.update_cell(p, position, value) end)
  end

  defp blank_cells(puzzle) do
    puzzle.cells
    |> Enum.filter(fn {_, v} -> is_nil(v) end)
    |> Enum.sort()
    |> Map.new()
  end

  defp get_last_possible_numbers(cells, puzzle) do
    Enum.reduce(cells, [], fn {{i, j}, _value} = cell, acc ->
      possible_values = possible_numbers_for(cell, puzzle)

      if length(possible_values) == 1 do
        [{{i, j}, hd(possible_values)} | acc]
      else
        acc
      end
    end)
  end

  defp possible_numbers_for({{i, j}, nil}, puzzle) do
    row_values = puzzle |> Puzzle.get_row_values(i) |> MapSet.new()
    column_values = puzzle |> Puzzle.get_column_values(j) |> MapSet.new()
    block_values = puzzle |> Puzzle.get_block_values(i, j) |> MapSet.new()

    MapSet.new(1..9)
    |> MapSet.difference(row_values)
    |> MapSet.difference(column_values)
    |> MapSet.difference(block_values)
    |> MapSet.to_list()
  end
end
