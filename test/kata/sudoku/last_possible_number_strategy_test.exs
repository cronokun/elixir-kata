defmodule Kata.SudokuSolver.LastPossibleNumberStrategyTest do
  use ExUnit.Case, async: true

  import SudokuTestHelper

  test ".fill_in/1 fills cells with last possible number in row, column and block" do
    assert_puzzle_changed(
      [
        [0, 5, 0, 7, 8, 0, 0, 0, 0],
        [9, 0, 8, 2, 3, 0, 7, 5, 6],
        [2, 7, 4, 6, 1, 0, 0, 3, 9],
        [0, 4, 0, 9, 0, 0, 0, 0, 0],
        [0, 0, 0, 5, 0, 2, 0, 9, 8],
        [0, 0, 2, 0, 0, 3, 1, 0, 7],
        [0, 0, 0, 0, 0, 7, 0, 1, 0],
        [4, 3, 0, 0, 0, 0, 9, 0, 5],
        [1, 0, 9, 3, 0, 0, 0, 0, 0]
      ],
      [
        [0, 5, 0, 7, 8, 0, 0, 0, 0],
        [9, 1, 8, 2, 3, 4, 7, 5, 6],
        [2, 7, 4, 6, 1, 5, 8, 3, 9],
        [0, 4, 0, 9, 0, 0, 0, 0, 0],
        [0, 0, 0, 5, 0, 2, 0, 9, 8],
        [0, 0, 2, 0, 0, 3, 1, 0, 7],
        [0, 0, 0, 0, 0, 7, 0, 1, 0],
        [4, 3, 0, 0, 0, 0, 9, 0, 5],
        [1, 0, 9, 3, 0, 0, 0, 0, 0]
      ],
      Kata.SudokuSolver.LastPossibleNumberStrategy
    )
  end
end
