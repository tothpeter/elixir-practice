defmodule Excercise do
  import :timer, only: [ sleep: 1 ]

  def run do
    Process.flag(:trap_exit, true)

    spawn_link Excercise, :worker_proc, [self, "seniorita"]
    spawn_link Excercise, :worker_proc, [self, "senior"]

    sleep 0

    receive_messages(0)
  end

  # def worker_proc(_parent_pid, "seniorita"), do: raise :ponies

  def worker_proc(parent_pid, message) do
    send parent_pid, "good day #{message}"
  end

  def receive_messages(n) do
    receive do
      # {:EXIT, _pid, :normal} -> IO.inspect "a"
      message when is_binary(message) -> IO.puts message
      _message -> IO.inspect "aaaaaaaaaaaaaaaaaaaaaaaaa"

      IO.inspect n
      receive_messages(n+1)
    after 1500 ->
      IO.puts "End"
    end
  end
end

Excercise.run
