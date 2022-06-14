defmodule Kata.Permutations do
  @moduledoc """
  Find all uniq permutations of the given string.
  """

  def permutations(s) do
    s
    |> String.graphemes()
    |> do_perm()
    |> Enum.map(&Enum.join/1)
    |> Enum.uniq()
  end

  defp do_perm([]), do: [[]]

  defp do_perm(list) do
    for x <- list, y <- do_perm(list -- [x]), do: [x | y]
  end
end
