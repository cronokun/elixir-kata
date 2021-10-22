defmodule Kata.DescendingOrder do
  @moduledoc """
  Given an integer, return another with all it's digits rearranged in descending order.
  """

  def rearrange(n) do
    n
    |> Integer.digits()
    |> Enum.sort(:desc)
    |> Integer.undigits()
  end
end
