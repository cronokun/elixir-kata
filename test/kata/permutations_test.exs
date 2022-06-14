defmodule Kata.PermutationsTest do
  @moduledoc false

  use ExUnit.Case

  import Kata.Permutations

  test ".permutations/1" do
    assert permutations("a") == ~w[a]
    assert permutations("ab") == ~w[ab ba]
    assert permutations("aabb") == ~w[aabb abab abba baab baba bbaa]
  end
end
