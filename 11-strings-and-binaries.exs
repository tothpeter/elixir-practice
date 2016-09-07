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

  def anagram?(word1, word2) do
    Enum.sort(word1) == Enum.sort(word2)
  end

  def anagram2?(word1, word2) do
    Enum.sum(word1) == Enum.sum(word2)
  end
end

# IO.inspect MyString.printable_ascii?('123sad')
# IO.inspect MyString.printable_ascii?('∂x/∂y')

# IO.inspect MyString.anagram?('asd', 'dsa')
IO.inspect MyString.anagram2?('asd', 'dsa')


defmodule Calculator do
  def calculate(str) do
    do_parse(str, 0, nil, 0)
  end

  defp do_parse([ digit | tail ], first_number, operation, last_number) when digit in '0123456789' and operation == nil do
    do_parse(tail, first_number * 10 + digit - ?0, operation, last_number)
  end

  defp do_parse([ digit | tail ], first_number, operation, last_number) when digit in '0123456789' do
    do_parse(tail, first_number, operation, last_number * 10 + digit - ?0)
  end

  defp do_parse([ char | tail ], first_number, _operation, last_number) when char in '+-/*'  do
    do_parse(tail, first_number, char, last_number)
  end

  defp do_parse([], first_number, operation, last_number) do
    case operation do
      ?+ -> first_number + last_number
      ?- -> first_number - last_number
      ?/ -> first_number / last_number
      ?* -> first_number * last_number
    end
  end

  defp do_parse([ _digit | tail ], first_number, operation, last_number) do
    do_parse(tail, first_number, operation, last_number)
  end
end

defmodule Calculator2 do
  def calculate(str) do
    {rest, number1} = do_parse_number(str, 0)
    rest = do_remove_spaces(rest)
    {rest, operator} = do_parse_operator(rest)
    rest = do_remove_spaces(rest)
    {[], number2} = do_parse_number(rest, 0)

    do_operate(number1, operator, number2)
  end

  defp do_parse_number([ digit | tail ], result) when digit in '0123456789' do
    do_parse_number(tail, result * 10 + digit - ?0)
  end

  defp do_parse_number(str, result), do: {str, result}

  defp do_parse_operator([ char | tail ]),  do: {tail, char}

  defp do_remove_spaces([ ?\s | tail ]), do: do_remove_spaces(tail)
  defp do_remove_spaces(str), do: str

  defp do_operate(first_number, operator, last_number) do
    case operator do
      ?+ -> first_number + last_number
      ?- -> first_number - last_number
      ?/ -> first_number / last_number
      ?* -> first_number * last_number
    end
  end
end

# IO.inspect Calculator.calculate('123 + 27') # => 150
# IO.inspect Calculator2.calculate('123 + 27') # => 150
