ExUnit.start()

defmodule SudokuTestHelper do
  import ExUnit.Assertions

  alias Kata.SudokuSolver.Puzzle

  def assert_puzzle_changed(puzzle, expected, strategy) do
    actual =
      puzzle
      |> Puzzle.build()
      |> strategy.fill_in()
      |> Puzzle.to_raw()

    assert actual == expected
  end
end
