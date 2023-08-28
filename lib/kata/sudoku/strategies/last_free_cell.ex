defmodule Kata.SudokuSolver.LastFreeCellStrategy do
  alias Kata.SudokuSolver.Puzzle

  @moduledoc """
  "Last free cell" is the basic Sudoku solving technique. If only one cell left in a row, columns,
  or block we can just fill in missing number.

  Example:

  +-------+-------+-------+
  |░1░2░3░| . . . | . . 4 |
  |░4░5░6░| . . . | . . 7 |
  |░7░8░a░| . . . | . . 5 |
  +-------+-------+-------+
  | . . . | . . . | . . 2 |
  |░2░3░4░|░5░b░7░|░8░9░1 |
  | . . . | . . . | . . 3 |
  +-------+-------+-------+
  | . . . | . . . | . . 6 |
  | . . . | . . . | . . 9 |
  | . . . | . . . | . . c |
  +-------+-------+-------+

  (a) - in block 1 only number 9 is missing;
  (b) - in row 5 only number 6 is missing;
  (c) - in column 9 only number 8 is missing.
  """

  def apply(puzzle) do
    updated_puzzle = fill_in(puzzle)
    count_before = Puzzle.blank_cells_count(puzzle)
    count_after = Puzzle.blank_cells_count(updated_puzzle)

    IO.puts("[LastFreeCell] #{count_before} -> #{count_after} blank cells left")

    if count_after == count_before or count_after == 0 do
      updated_puzzle
    else
      apply(updated_puzzle)
    end
  end

  def fill_in(puzzle) do
    [
      last_free_cells_for(Puzzle.rows(puzzle)),
      last_free_cells_for(Puzzle.columns(puzzle)),
      last_free_cells_for(Puzzle.blocks(puzzle))
    ]
    |> List.flatten()
    |> Enum.reduce(puzzle, fn {position, value}, p ->
      Puzzle.update_cell(p, position, value)
    end)
  end

  defp last_free_cells_for(cells) do
    cells
    |> Map.values()
    |> Enum.reduce([], fn cells, acc ->
      case get_last_free_cell(cells) do
        {position, value} ->
          [{position, value} | acc]

        nil ->
          acc
      end
    end)
  end

  defp get_last_free_cell(cells) do
    {free, filled} = Enum.split_with(cells, fn {_, v} -> is_nil(v) end)

    if length(free) == 1 do
      position = free |> hd() |> elem(0)
      value = get_last_free_number(filled)

      {position, value}
    else
      nil
    end
  end

  @all_values [1, 2, 3, 4, 5, 6, 7, 8, 9]

  defp get_last_free_number(cells) do
    cells
    |> Enum.reduce(@all_values, fn {_, v}, vs -> List.delete(vs, v) end)
    |> hd()
  end
end
