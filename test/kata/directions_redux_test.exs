# test/kata/directions_redux_test.exs
defmodule Kata.DirectionsReduxTest do
  @moduledoc false

  use ExUnit.Case

  import Kata.DirectionsRedux, only: [reduce: 1, better_reduce: 1]

  describe ".reduce/1" do
    test "can't be reduced" do
      directions = ~w[NORTH WEST SOUTH EAST]
      message = "#{inspect(directions)} cannot be reduced further"

      assert reduce(directions) == directions, message
    end

    test "reduced to nil" do
      directions = ~w[NORTH SOUTH EAST WEST]

      assert reduce(directions) == []
    end

    test "simple reduce" do
      directions = ~w[EAST WEST WEST]
      reduced_directions = ~w[WEST]

      assert reduce(directions) == reduced_directions
    end

    test "complex reduce" do
      directions = ~w[NORTH SOUTH SOUTH EAST WEST NORTH WEST]
      reduced_directions = ~w[WEST]
      message = "#{inspect(directions)} can be reduced to #{inspect(reduced_directions)}"

      assert reduce(directions) == reduced_directions, message
    end
  end

  describe ".better_reduce/1" do
    test "can't be reduced" do
      directions = ~w[NORTH WEST SOUTH EAST]
      message = "#{inspect(directions)} cannot be reduced further"

      assert better_reduce(directions) == directions, message
    end

    test "reduced to nil" do
      directions = ~w[NORTH SOUTH EAST WEST]

      assert better_reduce(directions) == []
    end

    test "simple reduce" do
      directions = ~w[EAST WEST WEST]
      reduced_directions = ~w[WEST]

      assert better_reduce(directions) == reduced_directions
    end

    test "complex reduce" do
      directions = ~w[NORTH SOUTH SOUTH EAST WEST NORTH WEST]
      reduced_directions = ~w[WEST]
      message = "#{inspect(directions)} can be reduced to #{inspect(reduced_directions)}"

      assert better_reduce(directions) == reduced_directions, message
    end
  end
end
