defmodule Kata.SudokuSolver.LastPossibleNumberStrategyTest do
  use ExUnit.Case, async: true

  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.LastPossibleNumberStrategy, as: Strategy

  test ".apply/1 recursevly fills in cells while possible" do
    puzzle =
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
      ]
      |> Puzzle.build()
      |> Strategy.apply()
      |> Puzzle.to_raw()

    assert puzzle == [
             [3, 5, 6, 7, 8, 9, 4, 2, 1],
             [9, 1, 8, 2, 3, 4, 7, 5, 6],
             [2, 7, 4, 6, 1, 5, 8, 3, 9],
             [8, 4, 3, 9, 7, 1, 5, 6, 2],
             [7, 6, 1, 5, 4, 2, 3, 9, 8],
             [5, 9, 2, 8, 6, 3, 1, 4, 7],
             [6, 8, 5, 4, 9, 7, 2, 1, 3],
             [4, 3, 7, 1, 2, 6, 9, 8, 5],
             [1, 2, 9, 3, 5, 8, 6, 7, 4]
           ]
  end

  test ".fill_in/1 fills cells with last possible number in row, column and block" do
    puzzle =
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
      ]
      |> Puzzle.build()
      |> Strategy.fill_in()
      |> Puzzle.to_raw()

    assert puzzle == [
             [0, 5, 0, 7, 8, 0, 0, 0, 0],
             [9, 1, 8, 2, 3, 4, 7, 5, 6],
             [2, 7, 4, 6, 1, 5, 8, 3, 9],
             [0, 4, 0, 9, 0, 0, 0, 0, 0],
             [0, 0, 0, 5, 0, 2, 0, 9, 8],
             [0, 0, 2, 0, 0, 3, 1, 0, 7],
             [0, 0, 0, 0, 0, 7, 0, 1, 0],
             [4, 3, 0, 0, 0, 0, 9, 0, 5],
             [1, 0, 9, 3, 0, 0, 0, 0, 0]
           ]
  end
end
