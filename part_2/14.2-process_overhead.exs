defmodule Chain do
  def create_processes(n) do
    last_pid = Enum.reduce(1..n, self, fn(_, next_pid) -> spawn(Chain, :counter, [next_pid]) end)

    send(last_pid, 0)

    receive do
      final_count when is_integer(final_count) -> IO.puts "Final count: #{final_count}"
    end
  end

  def counter(next_pid) do
    receive do
      count -> send(next_pid, count + 1)
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

Chain.run 100_000
