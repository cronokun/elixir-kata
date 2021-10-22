# test/kata/duplicates_count_test.exs
defmodule Kata.DuplicateCountTest do
  @moduledoc false

  import Kata.DuplicateCount, only: [count: 1, basic_count: 1]

  use ExUnit.Case

  @long_text "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

  test ".count/1" do
    assert count("") == 0
    assert count("abcde") == 0
    assert count("aabbcde") == 2
    assert count("aabBcde") == 2
    assert count("Indivisibility") == 1
    assert count("Indivisibilities") == 2
    assert count(@long_text) == 23
  end

  test ".basic_count/1" do
    assert basic_count("") == 0
    assert basic_count("abcde") == 0
    assert basic_count("aabbcde") == 2
    assert basic_count("aabBcde") == 2
    assert basic_count("Indivisibility") == 1
    assert basic_count("Indivisibilities") == 2
    assert basic_count(@long_text) == 23
  end
end
