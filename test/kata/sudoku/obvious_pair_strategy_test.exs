defmodule Kata.SudokuSolver.ObviousPairStrategyTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.ObviousPairStrategy

  test ".run/1 removes obvious pair numbers from hints in the same block" do
    puzzle =
      Puzzle.build([
        [5, 0, 0, 6, 1, 3, 7, 2, 8],
        [8, 3, 1, 2, 5, 7, 9, 4, 6],
        [6, 7, 2, 9, 8, 4, 1, 3, 5],
        [0, 0, 5, 0, 0, 8, 2, 6, 0],
        [9, 2, 8, 5, 6, 1, 4, 7, 3],
        [0, 0, 0, 0, 0, 0, 5, 8, 0],
        [2, 0, 0, 1, 9, 0, 0, 5, 7],
        [3, 0, 0, 7, 4, 5, 0, 1, 2],
        [1, 5, 7, 0, 0, 0, 0, 9, 4]
      ])

    updated_puzzle = ObviousPairStrategy.run(puzzle)

    assert updated_puzzle.hints[{4, 5}] == [7]
    assert updated_puzzle.hints[{6, 5}] == [2, 7]
  end
end
