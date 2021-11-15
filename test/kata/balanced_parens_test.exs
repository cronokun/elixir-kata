defmodule Kata.BalancedParensTest do
  @moduledoc false

  use ExUnit.Case

  import Kata.BalancedParens, only: [balanced_parens: 1]

  test ".balanced_parens/1" do
    assert balanced_parens(0) == [""]
    assert balanced_parens(1) == ~w[()]
    assert balanced_parens(2) == ~w[(()) ()()]

    assert balanced_parens(3) == ~w[
      ((()))
      (()())
      (())()
      ()(())
      ()()()
    ]

    assert balanced_parens(4) == ~w[
      (((())))
      ((()()))
      ((())())
      ((()))()
      (()(()))
      (()()())
      (()())()
      (())(())
      (())()()
      ()((()))
      ()(()())
      ()(())()
      ()()(())
      ()()()()
    ]

    assert balanced_parens(5) == ~w[
      ((((()))))
      (((()())))
      (((())()))
      (((()))())
      (((())))()
      ((()(())))
      ((()()()))
      ((()())())
      ((()()))()
      ((())(()))
      ((())()())
      ((())())()
      ((()))(())
      ((()))()()
      (()((())))
      (()(()()))
      (()(())())
      (()(()))()
      (()()(()))
      (()()()())
      (()()())()
      (()())(())
      (()())()()
      (())((()))
      (())(()())
      (())(())()
      (())()(())
      (())()()()
      ()(((())))
      ()((()()))
      ()((())())
      ()((()))()
      ()(()(()))
      ()(()()())
      ()(()())()
      ()(())(())
      ()(())()()
      ()()((()))
      ()()(()())
      ()()(())()
      ()()()(())
      ()()()()()
    ]
  end
end
