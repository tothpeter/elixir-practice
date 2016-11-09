defmodule Times2 do
  def double(n) do
    n * 2
  end

  def triple(n), do: n * 3
  def quadruple(n), do: double(double(n))
end

# IO.puts Times.double "a"
# IO.puts Times.triple 3
# IO.puts Times.quadruple 2

defmodule Factorial do
  def of(0), do: 1
  def of(n) when n > 0 do
    n * of(n - 1)
  end
end

defmodule Sum do
  def of(1), do: 1
  def of(n), do: n + of(n - 1)
end

defmodule Excercise do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

# IO.puts Factorial.of 4
# IO.puts Sum.of 4
# IO.puts Excercise.gcd(12, 8)

# guess(actual, range)

# defmodule Chop do
#   def guess(actual, first.._last) when actual == first do
#     first
#   end
#
#   def guess(actual, _first..last) when actual == last do
#     last
#   end
#
#   def guess(actual, first..last) do
#     guess(actual, guess_range(actual, first..last))
#   end
#
#   def guess_range(actual, first..last) do
#     guessed = first + div((last - first), 2)
#     IO.puts "Guessed #{guessed}"
#
#     if actual < guessed do
#       first..guessed
#     else
#       guessed..last
#     end
#   end
# end




# defmodule Chop do
#   def guess(actual, first..last) do
#     if actual != first and actual != last do
#       guess(actual, guess_range(actual, first..last))
#     end
#   end
#
#   def guess_range(actual, first..last) do
#     guessed = first + div((last - first), 2)
#     IO.puts "Guessed #{guessed}"
#
#     if actual < guessed do
#       first..guessed
#     else
#       guessed..last
#     end
#   end
# end


defmodule Chop do
  def guess(actual, range = first..last) do
    guessed = div(last + first, 2)
    IO.puts "Guessed: #{guessed}"

    _guess(actual, range, guessed)
  end

  defp _guess(actual, _, actual) do
    IO.puts "Found it"
  end

  defp _guess(actual, first.._last, guessed) when actual < guessed do
    guess(actual, first..guessed-1)
  end

  defp _guess(actual, _first..last, guessed) when actual > guessed do
    guess(actual, guessed+1..last)
  end
end

Chop.guess(273, 1..1000)
