defmodule Sequence.Stash do
  use GenServer

  # Client

  def start_link(current_number) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_number)
  end

  def save_value(pid, value) do
    GenServer.cast(pid, {:save_value, value})
  end

  def get_value(pid) do
    GenServer.call(pid, :get_value)
  end

  # Server

  def handle_call(:get_value, _from, current_number) do
    { :reply, current_number, current_number }
  end

  def handle_cast({:save_value, value}, _current_number) do
    { :noreply, value }
  end
end
