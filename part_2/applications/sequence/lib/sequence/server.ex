defmodule Sequence.Server do
  use GenServer

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
end

# To test
# r Sequence.Server
# { :ok, pid } = GenServer.start_link(Sequence.Server, 100)
# GenServer.call(pid, :next_number)
# GenServer.cast(pid, {:increment, 10})
# GenServer.call(pid, {:set_number, 10})
