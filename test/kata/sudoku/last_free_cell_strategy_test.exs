defmodule Kata.SudokuSolver.LastFreeCellStrategyTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.LastFreeCellStrategy, as: Strategy

  test ".fill_in/1 fills in last free cell in block, row, or column" do
    puzzle =
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
      ]
      |> Puzzle.build()
      |> Strategy.fill_in()

    assert puzzle.cells[{3, 3}] == 9
    assert puzzle.cells[{5, 5}] == 6
    assert puzzle.cells[{9, 9}] == 8
  end

  test ".apply/1 recursively filles in free cells until no blank cells remains" do
    puzzle =
      [
        [0, 8, 4, 1, 3, 5, 6, 7, 2],
        [2, 5, 0, 0, 4, 6, 8, 3, 1],
        [6, 1, 3, 7, 2, 8, 5, 4, 9],
        [1, 9, 6, 0, 5, 7, 2, 8, 4],
        [0, 4, 5, 8, 1, 2, 0, 9, 6],
        [8, 3, 2, 6, 9, 4, 1, 5, 7],
        [3, 7, 0, 0, 6, 9, 0, 1, 5],
        [5, 6, 1, 0, 7, 3, 9, 2, 8],
        [4, 2, 0, 5, 8, 1, 7, 6, 3]
      ]
      |> Puzzle.build()
      |> Strategy.apply()
      |> Puzzle.to_raw()

    assert puzzle == [
             [9, 8, 4, 1, 3, 5, 6, 7, 2],
             [2, 5, 7, 9, 4, 6, 8, 3, 1],
             [6, 1, 3, 7, 2, 8, 5, 4, 9],
             [1, 9, 6, 3, 5, 7, 2, 8, 4],
             [7, 4, 5, 8, 1, 2, 3, 9, 6],
             [8, 3, 2, 6, 9, 4, 1, 5, 7],
             [3, 7, 8, 2, 6, 9, 4, 1, 5],
             [5, 6, 1, 4, 7, 3, 9, 2, 8],
             [4, 2, 9, 5, 8, 1, 7, 6, 3]
           ]
  end

  test ".apply/1 recursively filles in free cells while possible" do
    puzzle =
      [
        [0, 0, 4, 1, 3, 5, 6, 7, 2],
        [2, 5, 0, 0, 4, 6, 8, 3, 1],
        [6, 1, 3, 7, 2, 8, 5, 4, 9],
        [1, 9, 6, 0, 5, 7, 2, 8, 4],
        [0, 4, 5, 8, 1, 2, 0, 9, 6],
        [8, 3, 2, 6, 9, 4, 1, 5, 7],
        [3, 7, 0, 0, 0, 9, 0, 1, 5],
        [5, 6, 1, 0, 7, 3, 0, 2, 0],
        [4, 2, 0, 5, 8, 1, 0, 0, 3]
      ]
      |> Puzzle.build()
      |> Strategy.apply()
      |> Puzzle.to_raw()

    assert puzzle == [
             [9, 8, 4, 1, 3, 5, 6, 7, 2],
             [2, 5, 7, 9, 4, 6, 8, 3, 1],
             [6, 1, 3, 7, 2, 8, 5, 4, 9],
             [1, 9, 6, 3, 5, 7, 2, 8, 4],
             [7, 4, 5, 8, 1, 2, 3, 9, 6],
             [8, 3, 2, 6, 9, 4, 1, 5, 7],
             [3, 7, 0, 0, 6, 9, 0, 1, 5],
             [5, 6, 1, 0, 7, 3, 0, 2, 8],
             [4, 2, 0, 5, 8, 1, 0, 6, 3]
           ]
  end
end
