defmodule Kata.BalancedParens do
  @moduledoc """
  Write a function which makes a list of strings representing all of the ways you can balance N pairs of parentheses.
  """

  @spec balanced_parens(integer) :: list(String.t())
  def balanced_parens(n) do
    parens("", n, n)
  end

  defp parens(str, 0, 0), do: [str <> ""]
  defp parens(str, 1, 1), do: [str <> "()"]
  defp parens(str, 0, n), do: [str <> String.duplicate(")", n)]
  defp parens(str, n, n), do: parens(str <> "(", n - 1, n)
  defp parens(str, m, n), do: parens(str <> "(", m - 1, n) ++ parens(str <> ")", m, n - 1)
end
