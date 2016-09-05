defmodule MyEnum do
  def all?(list), do: all?(list, &(!!&1))

  def all?([], _fun), do: true

  def all?([ head | tail ], fun) do
    if fun.(head) do
      all?(tail, fun)
    else
      false
    end
  end


  def each([], _), do: :ok
  def each([ head | tail ], fun) do
    fun.(head)
    each(tail, fun)
  end


  def filter([], _), do: []

  def filter([ head | tail ], fun) do
    if fun.(head) do
      [head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end


  def take([ head | tail ], count) when count > 0 do
    [head | take(tail, count - 1)]
  end

  def take(_, 0), do: []

  def take([], _), do: []



  def split(list, count) do
    _split(list, [], [], count)
  end

  def _split([], front, back, _), do: {Enum.reverse(front), Enum.reverse(back)}

  def _split([ head | tail ], front, back, count) do
    if count > 0 do
      _split(tail, [head | front], back, count - 1)
    else
      _split(tail, front, [ head | back ], count - 1)
    end
  end


  # No need more variable, we can store the first part in acc, and then the rest is the tail or []
  def split2(list, count) do
    _split2(list, count, [])
  end

  def _split2([ head | tail ], count, acc) when count > 0 do
    _split2(tail, count - 1, [head | acc])
  end

  def _split2(list, 0, acc), do: { Enum.reverse(acc), list }

  def _split2([], _, acc), do: { Enum.reverse(acc), [] }


  # [ 1, [ 2, 3, [4] ], 5, [[[6]]]]

  def flatten(list), do: _flatten(list, [])

  defp _flatten([], final), do: Enum.reverse(final)

  defp _flatten([ [ h | [] ] | tail ], final) do
    _flatten([h | tail], final)
  end

  defp _flatten([ [ h | t ] | tail ], final) do
    _flatten([h, t | tail], final)
  end


  defp _flatten([ head | tail ], final) do
    _flatten(tail, [head | final])
  end

end

# test_list = [1,2,5,3,4,5]
# IO.inspect MyEnum.all?([true, true])
# IO.inspect MyEnum.all?(test_list, &(&1 > 6))
# IO.inspect MyEnum.all?(test_list, &(&1 < 6))
# IO.inspect MyEnum.each(test_list, &IO.puts(&1))

# IO.inspect MyEnum.filter(test_list, &(&1 > 4))
# IO.inspect MyEnum.filter(test_list, &(&1 < 6))

# IO.inspect MyEnum.take(test_list, 3)

# IO.inspect MyEnum.split(test_list, 3)
# IO.inspect MyEnum.split2(test_list, 3)
# IO.inspect MyEnum.split2(test_list, 0)
# IO.inspect MyEnum.split2(test_list, 30)

IO.inspect MyEnum.flatten([ 1, [ 2, 3, [4] ], 5, [[[6]]]])
