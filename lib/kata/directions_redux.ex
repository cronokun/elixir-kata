defmodule Kata.DirectionsRedux do
  @moduledoc """
  Reduce given directions to remove needless ones, like going North and then immediately South.
  """

  @spec reduce([String.t()]) :: [String.t()]
  def reduce(directions) do
    do_reduce(directions, [])
  end

  defp do_reduce(directions, prev_directions) when directions == prev_directions, do: directions

  defp do_reduce(directions, _) do
    directions
    |> reduce_once()
    |> do_reduce(directions)
  end

  defp reduce_once([]), do: []
  defp reduce_once([a]), do: [a]

  defp reduce_once([a | [b | tail]]) do
    if oposite?(a, b) do
      reduce_once(tail)
    else
      [a] ++ reduce_once([b | tail])
    end
  end

  defp oposite?("EAST", "WEST"), do: true
  defp oposite?("WEST", "EAST"), do: true
  defp oposite?("NORTH", "SOUTH"), do: true
  defp oposite?("SOUTH", "NORTH"), do: true
  defp oposite?(_, _), do: false

  @doc "Better solution with `List.foldr`."
  @spec reduce([String.t()]) :: [String.t()]
  def better_reduce(directions) do
    List.foldr(directions, [], &better_reduce/2)
  end

  defp better_reduce(head, []), do: [head]
  defp better_reduce("NORTH", ["SOUTH" | tail]), do: tail
  defp better_reduce("SOUTH", ["NORTH" | tail]), do: tail
  defp better_reduce("WEST", ["EAST" | tail]), do: tail
  defp better_reduce("EAST", ["WEST" | tail]), do: tail
  defp better_reduce(head, [next | tail]), do: [head, next | tail]
end
