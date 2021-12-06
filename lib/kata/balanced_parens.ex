defmodule Kata.BalancedParens do
  @moduledoc """
  Write a function which makes a list of strings representing all of the ways you can balance N pairs of parentheses.

  Improved version with tail-optimization.
  """

  @spec balanced_parens(integer) :: list(String.t())
  def balanced_parens(n) do
    parens("", n, n, [])
  end

  def balanced_parens_count(n) do
    n |> clever_balanced_parens() |> length()
  end

  defp parens(str, 1, 1, list), do: [str <> "()" | list]
  defp parens(str, 0, n, list), do: [str <> String.duplicate(")", n) | list]
  defp parens(str, n, n, list), do: parens(str <> "(", n - 1, n, list)

  defp parens(str, m, n, list) do
    parens(str <> "(", m - 1, n, parens(str <> ")", m, n - 1, list))
  end

  def clever_balanced_parens(n) when n < 0, do: []
  def clever_balanced_parens(0), do: [""]
  def clever_balanced_parens(n) when n > 0 do
    for cn <- 0..n,
      s0 <- clever_balanced_parens(cn - 1),
      s1 <- clever_balanced_parens(n - cn)
    do
      "(" <> s0 <> ")" <> s1
    end
  end
end
