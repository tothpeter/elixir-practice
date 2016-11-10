defmodule Sequence.Server do
  use GenServer

  def handle_call(:next_number, _from, current_number) do
    { :reply, current_number, current_number + 1 }
  end

  def handle_call({:set_number, new_number}, _from, current_number) do
    { :reply, new_number, new_number }
  end

  def handle_call(_any, _from, current_number) do
    { :reply, {:error, "Dunno what to do"}, current_number + 1 }
  end
end
