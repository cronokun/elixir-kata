defmodule Kata.SudokuSolver.ObviousPairStrategy do
  @moduledoc """
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
  """

  alias Kata.SudokuSolver.Puzzle

  def run(puzzle) do
    puzzle |> get_rejected_hints() |> update_hints(puzzle)
  end

  defp get_rejected_hints(puzzle) do
    []
  end

  defp update_hints(rejected_hints, puzzle) do
    flatten_hitns = for {n, cells} <- rejected_hints, cell <- cells, do: {cell, n}

    Enum.reduce(flatten_hitns, puzzle, fn {position, n}, p ->
      update_in(p, [Access.key!(:hints), position], &List.delete(&1, n))
    end)
  end
end
