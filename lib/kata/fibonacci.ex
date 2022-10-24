defmodule Kata.Fibonacci do
  @moduledoc """
  Advanced Fibonacci implementation that are able to calculate 1,000,000th Fibinacci number.

  Fibonacci number calculated like this:

  fib(0) = 0
  fib(1) = 1
  fib(n) = fib(n-1) + fib(n-2)
  """

  import Integer, only: [pow: 2]

  def fib(0), do: 0
  def fib(1), do: 1

  def fib(n) when n > 1 do
    2..n
    |> Enum.reduce({0, 1}, fn _n, {a, b} -> {b, a + b} end)
    |> elem(1)
  end

  def fib(nn) when nn < 0 do
    n = abs(nn)
    fib(n) * pow(-1, n + 1)
  end
end
