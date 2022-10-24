defmodule Kata.IFS do
  @moduledoc """
  # What is an IFS?

  One way to consider it is that it starts with a base canvas and various sub-canvases. The first iterations draws the main canvas one color except for where the sub canvases are, which are colored a different color. Each subsequent iterations has the sub canvas act as if it is the canvas in the prior iteration. The image above shows the first 8 iterations of the famous Sierpinski Triangle when made using its IFS.

  The 2 parts that define an IFS are the positions of all the sub-canvases and the number of iterations that it goes to before stopping.

  Normally an IFS's sub-canvases can be any size, they can be rotated, scaled, skewed etc. and there can be any number of them. They can even go off of the main canvas or be bigger than the canvas entirely, but the function you'll be making won't need to be quite so expansive.

  It's also probably worth noting that I'm mainly thinking of 2 dimensional fractals, though IFSes work with any number of dimensions.

  # The coding problem

  Your task is to create a function that takes in a 2 dimensional array and a positive integer and outputs a string that represents the defined IFS. The 2 dimensional array input will effectively cut up the canvas; each item in the 2 dimensional array will either be a 1 or a 0 corresponding to whether or not that slice of the canvas contains a sub-canvas. The positive integer input is the number of iterations to run the IFS. The output must be a string with line breaks for each line. A pixel is either a "#" and a space for ON or 2 spaces for OFF.

  # Examples

  This should output the Sierpinski Triangle’s 3rd iteration:

  > ifs([[1, 0], [1, 1]], 3)

  which looks like

    #
    # #
    #   #
    # # # #
    #       #
    # #     # #
    #   #   #   #
    # # # # # # # #

  Note that if you were to expand the 2 dimensional array into a square it would be

    [
      [1, 0],
      [1, 1]
    ]

  and if you look at the image at the top, that is what the first iteration looks like.

  The first 3 iterations of the Sirpinski Triangle:

  > ifs([[1, 0], [1, 1]], 1);

    #
    # #

  ifs([[1, 0], [1, 1]], 2);

    #
    # #
    #   #
    # # # #

  ifs([[1, 0],[1, 1]], 3);

    #
    # #
    #   #
    # # # #
    #       #
    # #     # #
    #   #   #   #
    # # # # # # # #

  """

  def ifs(base, iterations) do
    do_ifs(base, iterations) |> to_output()
  end

  defp do_ifs(base, 1), do: base

  defp do_ifs(base, iterations) do
    do_ifs(base ++ duplicate(base), iterations - 1)
  end

  defp duplicate(base) do
    max_length = length(List.last(base))

    Enum.map(base, fn row ->
      padding = List.duplicate(0, max_length - length(row))
      List.duplicate(row ++ padding, 2) |> List.flatten()
    end)
  end

  def to_output(canvas) do
    padding = canvas |> List.last() |> length

    iolist =
      Enum.reduce(canvas, [], fn list, acc ->
        [acc, [line_to_str(list, padding), "\n"]]
      end)

    IO.chardata_to_string(iolist)
  end

  defp line_to_str(list, padding) do
    Enum.map(list, fn segment ->
      case segment do
        0 -> "  "
        1 -> "# "
      end
    end)
    |> IO.chardata_to_string()
    |> String.pad_trailing(padding * 2, " ")
  end
end
