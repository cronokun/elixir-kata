defmodule Kata.SudokuSolver.LastFreeCellStrategyTest do
  @moduledoc false

  use ExUnit.Case, async: true

  import SudokuTestHelper

  test ".run/1 fills in last free cell in block, row, or column" do
    assert_puzzle_changed(
      [
        [1, 2, 3, 0, 0, 0, 0, 0, 4],
        [4, 5, 6, 0, 0, 0, 0, 0, 7],
        [7, 8, 0, 0, 0, 0, 0, 0, 5],
        [0, 0, 0, 0, 0, 0, 0, 0, 2],
        [2, 3, 4, 5, 0, 7, 8, 9, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 3],
        [0, 0, 0, 0, 0, 0, 0, 0, 6],
        [0, 0, 0, 0, 0, 0, 0, 0, 9],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
      ],
      [
        [1, 2, 3, 0, 0, 0, 0, 0, 4],
        [4, 5, 6, 0, 0, 0, 0, 0, 7],
        [7, 8, 9, 0, 0, 0, 0, 0, 5],
        [0, 0, 0, 0, 0, 0, 0, 0, 2],
        [2, 3, 4, 5, 6, 7, 8, 9, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 3],
        [0, 0, 0, 0, 0, 0, 0, 0, 6],
        [0, 0, 0, 0, 0, 0, 0, 0, 9],
        [0, 0, 0, 0, 0, 0, 0, 0, 8]
      ],
      Kata.SudokuSolver.LastFreeCellStrategy
    )
  end
end
