defmodule Sequence.StackServer do
  use GenServer

  def handle_call(:pop, _from, []), do: { :reply, nil, [] }

  def handle_call(:pop, _from, current_stack) do
    last = List.last(current_stack)
    tail = List.delete_at(current_stack, -1)

    { :reply, {last, tail}, tail }
  end
end

# Just an alternative solution
defmodule Sequence.StackServer2 do
  use GenServer

  def init(list), do: { :ok, Enum.reverse(list) }

  def handle_call(:pop, _from, []), do: { :reply, nil, [] }

  def handle_call(:pop, _from, [ last | tail ]), do: { :reply, last, tail }
end

# To test
# { :ok, pid } = GenServer.start_link(Sequence.StackServer2, [1, 2, 3])
# GenServer.call(pid, :pop)
