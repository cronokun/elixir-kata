defmodule Kata.FibonacciTest do
  use ExUnit.Case

  import Kata.Fibonacci

  test "first 10 numbers" do
    assert Enum.map(0..10, &fib(&1)) == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  end

  test "100th" do
    assert fib(100) == 354_224_848_179_261_915_075
  end

  test "negative numbers" do
    assert Enum.map(0..-10, &fib(&1)) == [0, 1, -1, 2, -3, 5, -8, 13, -21, 34, -55]
  end
end
