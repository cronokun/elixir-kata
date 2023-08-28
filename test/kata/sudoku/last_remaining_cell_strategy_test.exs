defmodule Kata.SudokuSolver.LastRemainingCellStrategyTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.LastRemainingCellStrategy, as: Strategy

  test ".fill_in/1 fills in last free cell in block, row, or column" do
    puzzle =
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
      ]
      |> Puzzle.build()
      |> Strategy.fill_in()
      |> Puzzle.to_raw()

    assert puzzle == [
             [0, 0, 2, 9, 5, 1, 7, 8, 6],
             [0, 6, 0, 4, 0, 2, 3, 1, 9],
             [0, 0, 0, 0, 3, 0, 0, 5, 2],
             [7, 0, 0, 0, 8, 9, 2, 6, 0],
             [6, 8, 0, 0, 2, 0, 0, 7, 4],
             [2, 1, 9, 7, 4, 0, 8, 0, 0],
             [0, 2, 6, 8, 0, 0, 5, 4, 0],
             [0, 5, 0, 3, 0, 0, 6, 2, 0],
             [4, 7, 3, 0, 0, 0, 0, 0, 8]
           ]
  end

  test ".apply/1 recursively filles in free cells until no blank cells remains" do
    puzzle =
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
      ]
      |> Puzzle.build()
      |> Strategy.apply()
      |> Puzzle.to_raw()

    assert puzzle == [
             [3, 4, 2, 9, 5, 1, 7, 8, 6],
             [5, 6, 8, 4, 7, 2, 3, 1, 9],
             [1, 9, 7, 6, 3, 8, 4, 5, 2],
             [7, 3, 4, 5, 8, 9, 2, 6, 1],
             [6, 8, 5, 1, 2, 3, 9, 7, 4],
             [2, 1, 9, 7, 4, 6, 8, 3, 5],
             [9, 2, 6, 8, 1, 7, 5, 4, 3],
             [8, 5, 1, 3, 9, 4, 6, 2, 7],
             [4, 7, 3, 2, 6, 5, 1, 9, 8]
           ]
  end
end
