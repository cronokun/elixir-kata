defmodule Kata.AddTwoNumbers do
  @moduledoc """
  https://leetcode.com/problems/add-two-numbers/

  You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit.

  Add the two numbers and return the sum as a linked list.

  Complexity: O(max(n,m))
  """

  @spec calc([integer], [integer]) :: [integer]
  def calc(a, b) do
    do_calc(a, b, 0, []) |> Enum.reverse()
  end

  defp do_calc([], [], 0, result), do: result
  defp do_calc([], [], 1, result), do: [1 | result]

  defp do_calc([a | as], [], carry, result) do
    {sum, new_carry} = add_with_carry(a, 0, carry)

    do_calc([], as, new_carry, [sum | result])
  end

  defp do_calc([], [b | bs], carry, result) do
    {sum, new_carry} = add_with_carry(0, b, carry)

    do_calc([], bs, new_carry, [sum | result])
  end

  defp do_calc([a | as], [b | bs], carry, result) do
    {sum, new_carry} = add_with_carry(a, b, carry)

    do_calc(as, bs, new_carry, [sum | result])
  end

  defp add_with_carry(a, b, carry) do
    sum = (a + b + carry)

    if sum >= 10, do: {sum - 10, 1}, else: {sum, 0}
  end
end
