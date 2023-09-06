defmodule Kata.SudokuSolver.Validator do
  @moduledoc """
  Validate that puzzle is correct: every horizontal row, vertical column and 3x3 blocks have
  only numbers from 1 to 9, and every number is used only once per row, column, block.
  """

  alias Kata.SudokuSolver.Puzzle

  def verify(raw) when is_list(raw), do: raw |> Puzzle.build() |> verify()

  def verify(%Puzzle{} = puzzle) do
    # TODO: think of better errors, i.e. {:error, "duplicating number in row 3"}
    if all_cells_filled_in?(puzzle) and cells_filled_correctly?(puzzle) do
      :ok
    else
      :error
    end
  end

  def solved?(%Puzzle{} = puzzle) do
    all_cells_filled_in?(puzzle) and cells_filled_correctly?(puzzle)
  end

  defp all_cells_filled_in?(puzzle) do
    !Enum.any?(puzzle.cells, fn {_, value} -> is_nil(value) end)
  end

  defp cells_filled_correctly?(puzzle) do
    rows_filled_correctly?(puzzle) and
      columns_filled_correctly?(puzzle) and
      blocks_filled_correctly?(puzzle)
  end

  defp rows_filled_correctly?(puzzle) do
    subblock_filled_correctly?(puzzle, &Puzzle.get_row_values/2)
  end

  defp columns_filled_correctly?(puzzle) do
    subblock_filled_correctly?(puzzle, &Puzzle.get_column_values/2)
  end

  defp blocks_filled_correctly?(puzzle) do
    subblock_filled_correctly?(puzzle, &Puzzle.get_block_values/2)
  end

  defp subblock_filled_correctly?(puzzle, access_fn) do
    Enum.all?(for i <- 1..9, do: access_fn.(puzzle, i) |> correct_values?())
  end

  @correct_numbers MapSet.new(1..9)

  defp correct_values?(values) do
    values
    |> MapSet.new()
    |> MapSet.equal?(@correct_numbers)
  end
end
