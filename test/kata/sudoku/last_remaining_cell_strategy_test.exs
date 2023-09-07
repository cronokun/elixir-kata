defmodule Kata.SudokuSolver.LastRemainingCellStrategyTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import SudokuTestHelper

  test ".run/1 fills in last free cell in block, row, or column" do
    assert_puzzle_changed(
      [
        [0, 0, 2, 9, 5, 1, 7, 8, 6],
        [0, 6, 0, 4, 0, 0, 0, 1, 9],
        [0, 0, 0, 0, 3, 0, 0, 0, 2],
        [7, 0, 0, 0, 8, 9, 0, 6, 0],
        [0, 8, 0, 0, 2, 0, 0, 0, 4],
        [2, 1, 9, 7, 4, 0, 8, 0, 0],
        [0, 2, 6, 8, 0, 0, 5, 0, 0],
        [0, 5, 0, 3, 0, 0, 6, 2, 0],
        [4, 7, 3, 0, 0, 0, 0, 0, 8]
      ],
      [
        [0, 0, 2, 9, 5, 1, 7, 8, 6],
        [0, 6, 0, 4, 0, 2, 3, 1, 9],
        [0, 0, 0, 0, 3, 0, 0, 5, 2],
        [7, 0, 0, 0, 8, 9, 2, 6, 0],
        [6, 8, 0, 0, 2, 0, 0, 7, 4],
        [2, 1, 9, 7, 4, 0, 8, 0, 0],
        [0, 2, 6, 8, 0, 0, 5, 4, 0],
        [0, 5, 0, 3, 0, 0, 6, 2, 0],
        [4, 7, 3, 0, 0, 0, 0, 0, 8]
      ],
      Kata.SudokuSolver.LastRemainingCellStrategy
    )
  end
end
