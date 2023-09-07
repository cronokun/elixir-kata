defmodule Kata.Sudoku.ObviousSingleStrategyTest do
  use ExUnit.Case, async: true

  import SudokuTestHelper

  test ".run/1 fills in obvious numbers based on hints" do
    assert_puzzle_changed(
      [
        [0, 5, 0, 7, 8, 9, 0, 0, 1],
        [9, 1, 8, 2, 3, 4, 7, 5, 6],
        [2, 7, 4, 6, 1, 5, 8, 3, 9],
        [0, 4, 0, 9, 0, 0, 5, 0, 0],
        [0, 0, 0, 5, 0, 2, 0, 9, 8],
        [5, 9, 2, 0, 0, 3, 1, 0, 7],
        [0, 0, 5, 4, 9, 7, 0, 1, 0],
        [4, 3, 0, 0, 2, 0, 9, 0, 5],
        [1, 2, 9, 3, 5, 0, 0, 0, 0]
      ],
      [
        [0, 5, 0, 7, 8, 9, 0, 0, 1],
        [9, 1, 8, 2, 3, 4, 7, 5, 6],
        [2, 7, 4, 6, 1, 5, 8, 3, 9],
        [0, 4, 0, 9, 0, 0, 5, 0, 0],
        [0, 6, 0, 5, 0, 2, 0, 9, 8],
        [5, 9, 2, 8, 0, 3, 1, 0, 7],
        [0, 0, 5, 4, 9, 7, 0, 1, 0],
        [4, 3, 0, 0, 2, 0, 9, 0, 5],
        [1, 2, 9, 3, 5, 0, 0, 0, 4]
      ],
      Kata.SudokuSolver.ObviousSingleStrategy
    )
  end
end
