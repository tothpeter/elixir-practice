# We have two workers, the first needs more time to finish its work
# but we need to receive the result first from the first process

defmodule NondeterministicProcesses do
  def run do
    worker1_pid = spawn(NondeterministicProcesses, :worker1, [])
    worker2_pid = spawn(NondeterministicProcesses, :worker2, [])

    send(worker1_pid, self)
    send(worker2_pid, self)

    receiver(worker1_pid)
    receiver(worker2_pid)
  end

  def worker1() do
    receive do
      response_pid -> very_long_computing(); send(response_pid, self);
    end
  end

  def very_long_computing() do
    # Enum.map 1..200000, fn x -> :math.sin(x) end
    :timer.sleep(1000 * 2);
    IO.puts "Long computing proc finished #{inspect self}"
  end

  def worker2() do
    receive do
      response_pid -> IO.puts "Short computing proc finished #{inspect self}"; send(response_pid, self);
    end
  end

  def receiver(pid) do
    receive do
      ^pid -> IO.puts "Received: #{inspect pid}"
    end
  end
end

Enum.each 1..2, fn _ -> NondeterministicProcesses.run; IO.puts ""; end
