defmodule Kata.IFSTest do
  use ExUnit.Case

  import Kata.IFS, only: [ifs: 2, to_output: 1]

  describe ".ifs/2" do
    test "small square" do
      expected = """
      # #     
      # #     
      # # # # 
      # # # # 
      """

      assert ifs([[1, 1], [1, 1]], 2) == expected
    end

    test "small Sierpinski's Triangle" do
      expected = """
      #               
      # #             
      #   #           
      # # # #         
      #       #       
      # #     # #     
      #   #   #   #   
      # # # # # # # # 
      """

      assert ifs([[1, 0], [1, 1]], 3) == expected
    end
  end

  describe ".to_output/1" do
    test "prints resulting canvas" do
      canvas = [
        [1, 0],
        [1, 1],
        [1, 0, 1, 0],
        [1, 1, 1, 1],
        [1, 0, 0, 0, 1, 0],
        [1, 1, 0, 0, 1, 1],
        [1, 0, 1, 0, 1, 0, 1, 0],
        [1, 1, 1, 1, 1, 1, 1, 1]
      ]

      expected = """
      #               
      # #             
      #   #           
      # # # #         
      #       #       
      # #     # #     
      #   #   #   #   
      # # # # # # # # 
      """

      assert to_output(canvas) == expected
    end
  end
end
