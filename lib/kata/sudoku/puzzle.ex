defmodule Kata.SudokuSolver.Puzzle do
  @moduledoc """
  Internal representation of the puzzle. O(1) access to every cell.
  """

  defstruct cells: %{}, hints: %{}

  @doc "Build a puzzle structure from raw data"
  def build(raw) do
    %__MODULE__{}
    |> put_cells(List.flatten(raw), {1, 1})
    |> update_hints()
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
    puzzle
    |> put_in([Access.key!(:cells), {i, j}], value)
    |> update_hints_for({i, j}, value)
  end

  # FIXME: shouldn't really be public function
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

  def hints_count(puzzle), do: puzzle.hints |> Map.values() |> Enum.count()

  @doc "Convert puzzle back to nested list representation"
  def to_raw(%__MODULE__{} = puzzle) do
    for i <- 1..9, into: [] do
      for j <- 1..9, into: [] do
        puzzle.cells[{i, j}] || 0
      end
    end
  end

  @doc "Make a list of possible values for each black cell"
  def update_hints(puzzle) do
    hints =
      puzzle.cells
      |> Enum.filter(fn {_, value} -> is_nil(value) end)
      |> Enum.sort()
      |> Enum.map(fn cell -> get_hints_for_cell(puzzle, cell) end)
      |> Map.new()

    Map.put(puzzle, :hints, hints)
  end

  defp update_hints_for(puzzle, {ii, jj}, n) do
    {bis, bjs} = block_number(ii, jj) |> coords_by_block_number()

    puzzle.hints
    |> Enum.filter(fn {{i, j}, _} -> i == ii or j == jj or (i in bis and j in bjs) end)
    |> Enum.uniq()
    |> Enum.reduce(puzzle, fn {position, _}, p ->
      update_in(p, [Access.key!(:hints), position], &List.delete(&1, n))
    end)
    |> put_in([Access.key!(:hints), {ii, jj}], [])
  end

  @all_numbers [1, 2, 3, 4, 5, 6, 7, 8, 9]

  defp get_hints_for_cell(puzzle, {{i, j}, nil}) do
    row_values = get_row_values(puzzle, i)
    column_values = get_column_values(puzzle, j)
    block_values = get_block_values(puzzle, i, j)

    values = Enum.uniq(row_values ++ column_values ++ block_values)

    hints = @all_numbers -- values

    {{i, j}, hints}
  end
end
