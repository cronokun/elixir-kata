defmodule Kata.Divisible13 do
  @moduledoc false

  @sequence [1, 10, 9, 12, 3, 4]

  @spec thirt(integer) :: integer
  def thirt(n) do
    stationary_number(n)
  end

  defp stationary_number(number) do
    new_number = number |> prepare_date() |> calculate()

    if new_number == number do
      number
    else
      stationary_number(new_number)
    end
  end

  defp calculate(list) do
    Enum.reduce(list, 0, fn {a, b}, acc -> acc + a * b end)
  end

  defp prepare_date(number) do
    digits = number |> Integer.digits() |> Enum.reverse()
    seq_digits = @sequence |> Stream.cycle() |> Enum.take(length(digits))

    Enum.zip(digits, seq_digits)
  end
end
