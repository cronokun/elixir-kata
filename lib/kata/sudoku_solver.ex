defmodule Kata.SudokuSolver do
  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.Solver
  alias Kata.SudokuSolver.Validator

  def solve(raw) do
    solved =
      raw
      |> Puzzle.build()
      |> Solver.solve()
      |> Puzzle.to_raw()

    {:ok, solved}
  end

  def verify(raw), do: Validator.verify(raw)
end
