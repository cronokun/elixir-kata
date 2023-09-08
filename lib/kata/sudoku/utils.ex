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
  end

  @doc "Make a list of possible values for each black cell"
  def update_hints(puzzle) when map_size(puzzle.hints) > 0, do: puzzle

  def update_hints(puzzle) do
    hints =
      puzzle.cells
      |> Enum.filter(fn {_, value} -> is_nil(value) end)
      |> Enum.sort()
      |> Enum.map(fn cell -> get_hints_for_cell(puzzle, cell) end)
      |> Map.new()

    Map.put(puzzle, :hints, hints)
  end

  @all_numbers [1, 2, 3, 4, 5, 6, 7, 8, 9]

  defp get_hints_for_cell(puzzle, {{i, j}, nil}) do
    row_values = Puzzle.get_row_values(puzzle, i)
    column_values = Puzzle.get_column_values(puzzle, j)
    block_values = Puzzle.get_block_values(puzzle, i, j)

    values = Enum.uniq(row_values ++ column_values ++ block_values)

    hints = @all_numbers -- values

    {{i, j}, hints}
  end
end
