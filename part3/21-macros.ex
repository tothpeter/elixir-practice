defmodule My2 do
  def myif(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    case condition do
      val when val in [false, nil] -> else_clause
      _otherwise -> do_clause
    end
  end
end



# a = 1
# My.myif(a == 1, do: IO.puts("ttt"), else: IO.puts("fff"))
# My2.myif a == 1 do
#   IO.puts("ttt")
# else
#   IO.puts("fff")
# end


defmodule My do
  defmacro macro(param) do
    IO.inspect param
  end

  defmacro if(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _otherwise                   -> unquote(do_clause)
      end
    end
  end
end

defmodule Test do

  require My

  # My.macro :atom
  # #=> :atom
  # My.macro 1
  # #=> 1
  # My.macro 1.0
  # #=> 1.0
  # My.macro [1,2,3]
  # #=> [1,2,3]
  # My.macro "binaries"
  # #=> "binaries"
  # My.macro { 1, 2 }
  # #=> {1,2}
  # My.macro do: 1
  # #=> [do: 1]
  # # And these are represented by 3-element tuples
  # My.macro { 1,2,3,4,5 }
  # # => {:"{}",[line: 20],[1,2,3,4,5]}
  # My.macro do: ( a = 1; a+a )

  def if do
    a = 2

    My.if a == 1 do
      IO.puts("ttt")
    else
      IO.puts("fff")
    end
  end
end

# Test.if


defmodule Times do
  defmacro times_n(n) do
    method_name = :"times_#{n}"

    quote do
      def unquote(method_name)(k) do
        unquote(n) * k
      end
    end
  end
end


defmodule Test2 do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts Test2.times_3(4)
IO.puts Test2.times_4(5)
