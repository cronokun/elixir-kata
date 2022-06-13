defmodule Kata.Count9s do
  @moduledoc """
  Count how many times digit "9" is preset when counting from 1 to N.
  """

  def number9(n) do
    n |> digits() |> calculate()
  end

  defp calculate(digits, mult \\ 0, sum \\ 0)
  defp calculate([], _mult, sum), do: sum
  defp calculate([{n, p} | rest], mult, sum) do
    ss = do_calc(n, p)
    ssp = if mult > 0, do: n * p * mult, else: 0
    mm = if n == 9, do: mult + 1, else: mult

    calculate(rest, mm, sum + ss + ssp)
  end

  defp do_calc(9, p), do: 9 * delta(p) + 1
  defp do_calc(n, p), do: n * delta(p)


  defp delta(1), do: 0
  defp delta(10), do: 1
  defp delta(100), do: 20
  defp delta(m) do
    prev_m = Integer.floor_div(m, 10)
    10 * delta(prev_m) + prev_m
  end

  defp digits(n) do
    with d <- Integer.digits(n),
         m <- length(d) - 1,
         p <- Enum.map(m..0, &(10 ** &1)) do
      Enum.zip(d, p)
    end
  end
end
