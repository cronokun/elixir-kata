defmodule Kata.SudokuSolver.Puzzle do
  @moduledoc """
  Internal representation of the puzzle. O(1) access to every cell.
  """

  defstruct cells: %{}, hints: %{}

  @doc "Build a puzzle structure from raw data"
  def build(raw) do
    %__MODULE__{}
    |> put_cells(List.flatten(raw), {1, 1})
  end

  defp put_cells(puzzle, [], _), do: puzzle

  # TODO: any way to do this without recursion and manual row/column number calculation?
  defp put_cells(puzzle, [cell | rest], coords) do
    value = if cell == 0, do: nil, else: cell
    puzzle = update_cell(puzzle, coords, value)

    put_cells(puzzle, rest, next_coordinates(coords))
  end

  defp next_coordinates({i, 9}), do: {i + 1, 1}
  defp next_coordinates({i, j}), do: {i, j + 1}

  def blocks(puzzle) do
    puzzle.cells
    |> Enum.group_by(fn {{i, j}, _} -> block_number(i, j) end)
    |> Enum.sort()
    |> Map.new()
  end

  def columns(puzzle) do
    puzzle.cells
    |> Enum.group_by(fn {{_, j}, _} -> j end)
    |> Enum.sort()
    |> Map.new()
  end

  def rows(puzzle) do
    puzzle.cells
    |> Enum.group_by(fn {{i, _}, _} -> i end)
    |> Enum.sort()
    |> Map.new()
  end

  def get_block_values(puzzle, i, j), do: get_block_values(puzzle, block_number(i, j))

  def get_block_values(puzzle, n) do
    {is, js} = coords_by_block_number(n)

    puzzle.cells
    |> Enum.filter(fn {{r, c}, _} -> r in is and c in js end)
    |> Enum.map(fn {_coords, value} -> value end)
    |> Enum.reject(&is_nil/1)
  end

  def get_column_values(puzzle, j) do
    puzzle.cells
    |> Enum.filter(fn {{_, c}, _} -> c == j end)
    |> Enum.map(fn {_coords, value} -> value end)
    |> Enum.reject(&is_nil/1)
  end

  def get_row_values(puzzle, i) do
    puzzle.cells
    |> Enum.filter(fn {{r, _}, _} -> r == i end)
    |> Enum.map(fn {_coords, value} -> value end)
    |> Enum.reject(&is_nil/1)
  end

  def update_cell(puzzle, {i, j}, value) do
    put_in(puzzle, [Access.key!(:cells), {i, j}], value)
  end

  def block_number(i, j) when i in 1..3 and j in 1..3, do: 1
  def block_number(i, j) when i in 1..3 and j in 4..6, do: 2
  def block_number(i, j) when i in 1..3 and j in 7..9, do: 3
  def block_number(i, j) when i in 4..6 and j in 1..3, do: 4
  def block_number(i, j) when i in 4..6 and j in 4..6, do: 5
  def block_number(i, j) when i in 4..6 and j in 7..9, do: 6
  def block_number(i, j) when i in 7..9 and j in 1..3, do: 7
  def block_number(i, j) when i in 7..9 and j in 4..6, do: 8
  def block_number(i, j) when i in 7..9 and j in 7..9, do: 9

  defp coords_by_block_number(1), do: {1..3, 1..3}
  defp coords_by_block_number(2), do: {1..3, 4..6}
  defp coords_by_block_number(3), do: {1..3, 7..9}
  defp coords_by_block_number(4), do: {4..6, 1..3}
  defp coords_by_block_number(5), do: {4..6, 4..6}
  defp coords_by_block_number(6), do: {4..6, 7..9}
  defp coords_by_block_number(7), do: {7..9, 1..3}
  defp coords_by_block_number(8), do: {7..9, 4..6}
  defp coords_by_block_number(9), do: {7..9, 7..9}

  def blank_cells_count(puzzle), do: Enum.count(puzzle.cells, fn {_, value} -> is_nil(value) end)

  @doc "Converts puzzle back to nested list representation"
  def to_raw(%__MODULE__{} = puzzle) do
    for i <- 1..9, into: [] do
      for j <- 1..9, into: [] do
        puzzle.cells[{i, j}] || 0
      end
    end
  end

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
end
