defmodule Kata.DuplicateCount do
  @moduledoc """
  Count the number of Duplicates

  Write a function that will return the count of distinct case-insensitive alphabetic characters
  and numeric digits that occur more than once in the input string. The input string can be assumed
  to contain only alphabets (both uppercase and lowercase) and numeric digits.
  """

  @doc "Proper implementation using `Enum.frequencies_by/2`."
  @spec count(String.t()) :: integer
  def count(str) do
    str
    |> String.graphemes()
    |> Enum.frequencies_by(&String.downcase/1)
    |> Enum.reduce(0, fn {_key, val}, acc ->
      if val > 1, do: acc + 1, else: acc
    end)
  end

  @doc "Back to basics implementation using recursion."
  @spec count(String.t()) :: integer
  def basic_count(str) do
    str
    |> get_frequencies()
    |> count_duplicates()
  end

  defp get_frequencies(str, frequencies \\ %{})
  defp get_frequencies("", frequencies), do: frequencies

  defp get_frequencies(<<char::utf8, rest::binary>>, frequencies) do
    new_frequencies =
      Map.update(
        frequencies,
        String.downcase(<<char>>),
        1,
        &(&1 + 1)
      )

    get_frequencies(rest, new_frequencies)
  end

  defp count_duplicates(frequencies) do
    Enum.reduce(frequencies, 0, fn {_key, val}, acc ->
      if val > 1, do: acc + 1, else: acc
    end)
  end
end
