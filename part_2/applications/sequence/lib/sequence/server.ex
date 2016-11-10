defmodule Sequence.Server do
  use GenServer
  # Client

  def start_link(current_number) do
    GenServer.start_link(Sequence.Server, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment, delta})
  end

  # Server

  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1 }
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number }
  end

  def handle_call(_anything, _from, current_number) do
    { :reply, {:error, "Dunno what to do"}, current_number }
  end

  def handle_cast({:increment, delta}, current_number) do
    { :noreply, current_number + delta }
  end

  def format_status(_reason, [ _pdict, state ]) do
    [
      data: [
        { 'State', "My current state is '#{inspect state}', and I'm happy" },
        { :i_need_a_monk, "Hololo" }
      ]
    ]
  end
end

Sequence.Server.start_link(10)

IO.puts Sequence.Server.next_number
Sequence.Server.increment_number 5
IO.puts Sequence.Server.next_number

# To test
# r Sequence.Server
# { :ok, pid } = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
# GenServer.call(pid, :next_number)
# GenServer.cast(pid, {:increment, 10})
# GenServer.call(pid, {:set_number, 10})
# :sys.get_status pid
