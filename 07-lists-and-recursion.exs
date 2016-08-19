defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]

  def map([], _), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  def sum2(_, total \\ 0)
  def sum2([], total), do: total
  def sum2([head | tail], total), do: sum2(tail, head + total)

  def sum3(list), do: _sum3(list, 0)
  defp _sum3([], total), do: total
  defp _sum3([head | tail], total), do: _sum3(tail, head + total)

  def reduce([], value, _), do: value
  def reduce([head | tail], value, func), do: reduce(tail, func.(head, value), func)

  def mapsum([], _),               do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  def max([last_item]),   do: last_item
  def max([head | tail]), do: Kernel.max(max(tail), head)

  def max2([head | tail]),             do: _max2(tail, head)
  def _max2([], max_value),            do: max_value
  def _max2([head | tail], max_value), do: _max2(tail, Kernel.max(max_value, head))


  def caesar([], _), do: []

  def caesar([head | tail], offset)
    when head + offset <= ?z,
    do: [head + offset | caesar(tail, offset)]

  def caesar([head | tail], offset),
    do: [head + offset - 26 | caesar(tail, offset)]


  def swap([]), do: []
  def swap([ a, b | tail ]), do: [ b, a | swap(tail) ]
  def swap([x]), do: [x]
  # def swap([ _ ]), do: raise "Can't swap a list with an odd number of elements"


  def test_data do
    [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 15, 0.45],
      [1366225622, 28, 21, 0.25],
      [1366229222, 26, 19, 0.081],
      [1366229222, 27, 17, 0.468],
      [1366229222, 28, 15, 0.60],
      [1366232822, 26, 22, 0.095],
      [1366232822, 27, 21, 0.05],
      [1366232822, 28, 24, 0.03],
      [1366236422, 26, 17, 0.025]
    ]
  end

  def for_location([], _), do: []

  def for_location([ list = [_, target_loc, _, _] | tail ], target_loc) do
    [list | for_location(tail, target_loc)]
  end

  def for_location([ _ | tail ], target_loc) do
    for_location(tail, target_loc)
  end

  def span(from, from), do: [from]
  def span(from, to), do: [from | span(from + 1, to)]

  def span2(from, to) when from > to, do: []
  def span2(from, to), do: [from | span2(from + 1, to)]
end

# IO.puts MyList.len([1,2,3])
# IO.inspect MyList.square([1,2,3])
# IO.inspect MyList.map([1,2,3], &(&1 * 2))
# IO.inspect MyList.sum([1,2,3])
# IO.inspect MyList.sum2([1,2,3])
# IO.inspect MyList.sum3([1,2,3])
# IO.inspect MyList.reduce([1,2,3], 0, &(&1 + &2 + 1))
# IO.inspect MyList.mapsum([1,2,3], &(&1 + 1))
# IO.inspect MyList.max([1,9,2,3])
# IO.inspect MyList.max2([1,9,2,3])
# IO.inspect MyList.caesar('ryvkve', 13)
# IO.inspect MyList.swap([1,9,2,3, 5])
# IO.inspect MyList.for_location(MyList.test_data, 27)
# IO.inspect MyList.span(5,9)
IO.inspect MyList.span2(5,9)
