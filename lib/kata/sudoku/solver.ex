defmodule Kata.SudokuSolver.Solver do
  alias Kata.SudokuSolver.Puzzle
  alias Kata.SudokuSolver.Validator

  def solve(%Puzzle{} = puzzle) do
    updated_puzzle =
      puzzle
      |> update_hints()
      |> update_hints_by_blocks()
      |> fill_in_last_possible_numbers()

    cond do
      Validator.solved?(updated_puzzle) ->
        updated_puzzle

      puzzle_not_changed?(puzzle, updated_puzzle) ->
        IO.puts(
          "\n-----------------------------------  FAILED  -----------------------------------"
        )

        IO.inspect(Puzzle.to_raw(updated_puzzle), label: "\nPuzzle")
        IO.inspect(updated_puzzle.hints, label: "\nHints", limit: :infinity)
        raise "Can't solve the puzzle"

      true ->
        solve(updated_puzzle)
    end
  end

  defp puzzle_not_changed?(old_puzzle, updated_puzzle) do
    Puzzle.blank_cells_count(old_puzzle) == Puzzle.blank_cells_count(updated_puzzle)
  end

  defp update_hints(puzzle) do
    hints =
      for i <- 1..9, j <- 1..9, is_nil(puzzle.cells[{i, j}]), into: %{} do
        row_values = Puzzle.get_row_values(puzzle, i) |> MapSet.new()
        column_values = Puzzle.get_column_values(puzzle, j) |> MapSet.new()
        block_values = Puzzle.get_block_values(puzzle, i, j) |> MapSet.new()

        values =
          MapSet.new(1..9)
          |> MapSet.difference(row_values)
          |> MapSet.difference(column_values)
          |> MapSet.difference(block_values)

        {{i, j}, values}
      end

    Map.put(puzzle, :hints, hints)
  end

  defp update_hints_by_blocks(puzzle) do
    for n <- 1..9 do
      hints_for_block(puzzle, n)
    end
    |> Enum.reduce(%{}, fn hint, acc -> Map.merge(acc, hint) end)
    |> Enum.reduce(puzzle, fn {coords, hint}, p ->
      put_in(p, [Access.key!(:hints), coords], hint)
    end)
  end

  defp hints_for_block(puzzle, n) do
    {is, js} = Puzzle.coords_by_block_number(n)

    hints =
      puzzle.hints
      |> Enum.filter(fn {{i, j}, _} -> i in is and j in js end)

    freqs =
      hints
      |> Enum.reduce([], fn {_, vs}, acc -> acc ++ MapSet.to_list(vs) end)
      |> Enum.frequencies()

    single_out_hint_by_block(hints, freqs)
  end

  defp single_out_hint_by_block(hints, freqs) do
    for {n, count} <- freqs, count == 1, into: %{} do
      {coords, _} = Enum.find(hints, fn {_, values} -> MapSet.member?(values, n) end)
      {coords, MapSet.new([n])}
    end
  end

  defp fill_in_last_possible_numbers(puzzle) do
    Enum.reduce(puzzle.hints, puzzle, fn {coords, hints}, p ->
      if MapSet.size(hints) == 1 do
        value = hints |> MapSet.to_list() |> hd()
        Puzzle.update_cell(p, coords, value)
      else
        p
      end
    end)
  end
end
