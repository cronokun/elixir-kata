defmodule Kata.SumOfPairs do
  @moduledoc """
  Finds the first pair of ints as judged by the index of the second value.

  iex> sum_pairs([10, 5, 2, 3, 7, 5], 10)
  {3, 7}
  """

  @spec sum_pairs([integer], integer) :: {integer, integer} | nil
  def sum_pairs(list, sum) do
    list
    |> Enum.with_index()
    |> find_best_pair_indexes(sum)
    |> get_numbers(list)
  end

  defp find_best_pair_indexes(list, sum) do
    numbers = numbers_with_indexes(list)

    Enum.reduce(list, nil, fn {a, a_idx}, cur ->
      case Map.get(numbers, sum - a) do
        nil ->
          cur

        [^a_idx] ->
          cur

        indices ->
          b_idx = hd(indices -- [a_idx])
          update_current_indices(cur, {a_idx, b_idx})
      end
    end)
  end

  defp update_current_indices(nil, indices), do: indices
  defp update_current_indices({a, b}, {n, m}) when n > m, do: {a, b}
  defp update_current_indices({_a, b}, {n, m}) when m < b, do: {n, m}
  defp update_current_indices({a, b}, _), do: {a, b}

  defp get_numbers(nil, _list), do: nil

  defp get_numbers({a, b}, list) do
    {
      Enum.at(list, a),
      Enum.at(list, b)
    }
  end

  defp numbers_with_indexes(list) do
    list
    |> Enum.reduce(%{}, fn {val, idx}, acc ->
      Map.update(acc, val, [idx], fn indexes -> indexes ++ [idx] end)
    end)
  end

  @doc "Better O(n) implementation."
  @spec sum_pairs([integer], integer) :: {integer, integer} | nil
  def better_sum_pairs(list, sum) do
    get_sum_pairs(list, sum, MapSet.new())
  end

  defp get_sum_pairs([], _sum, _acc), do: nil

  defp get_sum_pairs([head | tail], sum, acc) do
    case MapSet.member?(acc, sum - head) do
      true ->
        {sum - head, head}

      false ->
        get_sum_pairs(tail, sum, MapSet.put(acc, head))
    end
  end
end
