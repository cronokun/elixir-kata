defmodule Kata.SudokuSolver.Utils do
  @moduledoc """
  Helper functions related to sudoku.
  """

  alias Kata.SudokuSolver.Puzzle

  @doc "Print puzzle to STDOUT"
  def print(puzzle, opts \\ []) do
    if opts[:label], do: IO.puts(opts[:label])

    for i <- 1..9, into: "" do
      row =
        for j <- 1..9, into: "" do
          val =
            case puzzle.cells[{i, j}] do
              nil -> "."
              n -> to_string(n)
            end

          sep = if j in [3, 6], do: "| ", else: ""
          val <> " " <> sep
        end

      sep = if i in [3, 6], do: "\n------+-------+------", else: ""

      row <> sep <> "\n"
    end
    |> IO.puts()

    if opts[:hints] do
      IO.inspect(puzzle.hints, label: "\n Hints", limit: :infinity, charlists: :as_lists)
    end
  end
end
