defmodule FizzBuzz do
  def upto(n), do: do_upto(n, [])

  defp do_upto(current, result) when current < 1, do: result

  defp do_upto(current, result) do
    next_result = cond do
      rem(current, 15) == 0 -> "FizzBuzz"
      rem(current, 3) == 0 -> "Fizz"
      rem(current, 5) == 0 -> "Buzz"
      true -> current
    end

    do_upto(current - 1, [ next_result | result ])
  end
end

# IO.inspect FizzBuzz.upto(30)

defmodule FizzBuzz2 do
  def upto(n) do
    1..n |> Enum.map(&do_upto(&1))
  end

  defp do_upto(current) do
    cond do
      rem(current, 15) == 0 -> "FizzBuzz"
      rem(current, 3) == 0 -> "Fizz"
      rem(current, 5) == 0 -> "Buzz"
      true -> current
    end
  end
end

IO.inspect FizzBuzz2.upto(30)
