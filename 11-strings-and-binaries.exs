defmodule MyParser do

  def number([ ?+ | tail]), do: do_number(tail, 0)
  def number([ ?- | tail]), do: do_number(tail, 0) * -1
  def number(str), do: do_number(str, 0)

  defp do_number([], result), do: result

  defp do_number([ digit | tail], result) when digit in '0123456789' do
    do_number(tail, result * 10 + digit - ?0)
  end

  defp do_number([ non_digit | _ ], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end
end

# IO.inspect MyParser.number('123')
# IO.inspect MyParser.number('-123')
# IO.inspect MyParser.number('+123')
# IO.inspect MyParser.number('asd')

defmodule MyString do
  def printable_ascii?(char_list) do
    # char_list |> Enum.all?(fn char -> char in 32..126 end)
    char_list |> Enum.all?(fn char -> char in ?\s..?~ end)
  end
end

IO.inspect MyString.printable_ascii?('123sad')
IO.inspect MyString.printable_ascii?('∂x/∂y')
