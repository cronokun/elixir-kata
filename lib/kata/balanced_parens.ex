defmodule Kata.BalancedParens do
  @moduledoc """
  Write a function which makes a list of strings representing all of the ways you can balance N pairs of parentheses.

  Improved version with tail-optimization.

  Prifiling:

  > mix profile.fprof -e "Kata.BalancedParens.clever_balanced_parens(10) |> length() |> IO.puts"

  (Elixir: 1.13.4-otp-25.0)

  n   | result | parens (ms)   | clever? (ms)
  ----+--------+---------------+-------------
  1   | 1      | 0.061         | 0.066
  2   | 2      | 0.065         | 0.144
  3   | 5      | 0.076         | 0.390
  4   | 14     | 0.099         | 1.203
  5   | 42     | 0.235         | 3.911
  6   | 132    | 0.638         | 13.186
  7   | 429    | 1.997         | 45.340
  8   | 1,430  | 6.553         | 158.094
  9   | 4,862  | 22.159        | 557.498
  10  | 16,796 | 76.729        | 1_988.232
  15  |        | 44,496.368    | ---
  """

  @spec balanced_parens(integer) :: list(String.t())
  def balanced_parens(n) do
    parens("", n, n, [])
  end

  defp parens(str, 1, 1, list), do: [str <> "()" | list]
  defp parens(str, 0, n, list), do: [str <> String.duplicate(")", n) | list]
  defp parens(str, n, n, list), do: parens(str <> "(", n - 1, n, list)

  defp parens(str, m, n, list) do
    parens(str <> "(", m - 1, n, parens(str <> ")", m, n - 1, list))
  end

  # (No so clever?) reference implementation.
  def clever_balanced_parens(n) when n < 0, do: []
  def clever_balanced_parens(0), do: [""]

  def clever_balanced_parens(n) when n > 0 do
    for cn <- 0..n,
        s0 <- clever_balanced_parens(cn - 1),
        s1 <- clever_balanced_parens(n - cn) do
      "(" <> s0 <> ")" <> s1
    end
  end
end
