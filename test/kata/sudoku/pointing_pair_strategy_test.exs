defmodule Kata.SudokuSolver.PointingPairStrategyTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.PointingPairStrategy
  alias Kata.SudokuSolver.HiddenSingleStrategy

  test ".run/1 fills in cells using painting pairs... or does it?!" do
    puzzle =
      Puzzle.build([
        [0, 0, 0, 4, 0, 0, 0, 9, 0],
        [0, 0, 0, 2, 5, 3, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 4, 7],
        [7, 5, 0, 9, 0, 0, 8, 6, 0],
        [0, 0, 4, 0, 0, 8, 0, 0, 0],
        [1, 0, 0, 0, 3, 5, 0, 0, 0],
        [0, 2, 5, 0, 0, 0, 4, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 5],
        [0, 3, 0, 5, 0, 1, 0, 0, 2]
      ])

    updated_puzzle =
      puzzle
      |> PointingPairStrategy.run()
      |> HiddenSingleStrategy.run()

    assert Puzzle.to_raw(updated_puzzle) == [
             [0, 0, 0, 4, 0, 0, 0, 9, 0],
             [0, 0, 0, 2, 5, 3, 0, 0, 0],
             [0, 0, 0, 1, 0, 0, 0, 4, 7],
             [7, 5, 0, 9, 0, 0, 8, 6, 0],
             [0, 0, 4, 0, 0, 8, 0, 5, 0],
             [1, 0, 0, 0, 3, 5, 0, 0, 4],
             [0, 2, 5, 0, 0, 0, 4, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 5],
             [0, 3, 0, 5, 0, 1, 0, 0, 2]
           ]
  end
end
