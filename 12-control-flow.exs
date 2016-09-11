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

# IO.inspect FizzBuzz2.upto(30)

defmodule FizzBuzz3 do
  def upto(n) do
    1..n |> Enum.map(&do_upto(&1))
  end

  defp do_upto(current) do
    case {rem(current, 3), rem(current, 5)} do
      {0, 0} -> "FizzBuzz"
      {_, 0} -> "Fizz"
      {0, _} -> "Buzz"
      {_, _} -> current
    end
  end
end

# IO.inspect FizzBuzz3.upto(30)


# defmodule Users do
#   dave = %{ name: "Dave", state: "TX", likes: "programming" }
#
#   case dave do
#     %{state: some_state} = person ->
#       IO.puts "#{person.name} lives in #{some_state}"
#     _ ->
#       IO.puts "No matches"
#   end
# end

defmodule ControlFlow do
  def ok!({:ok, data}), do: data
  def ok!({_, reason}), do: raise "Error occurred: #{reason}"
end

file = ControlFlow.ok! File.open("test_file")
IO.inspect file

file = ControlFlow.ok! File.open("not_exist")
IO.inspect file
