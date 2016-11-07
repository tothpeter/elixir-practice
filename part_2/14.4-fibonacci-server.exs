defmodule FibSolver do
  def solve(scheduler) do
    send(scheduler, { :ready, self })

    receive do
      { :fib, n, client, position } ->
        send(client, { :answer, position, fib(n) })
        solve(scheduler)
      { :shutdown } -> exit(:normal)
    end
  end

  def fib(1), do: 0
  def fib(2), do: 1

  def fib(n), do: fib(n - 2) + fib(n - 1)
end


defmodule FibScheduler do
  def run(max_procs_count, to_calculate) do
    (1..max_procs_count)
    |> Enum.map(fn(_) -> spawn(FibSolver, :solve, [self]) end)
    |> schedule(to_calculate, [])
  end

  def schedule(worker_pids, queue, results) do
    receive do
      { :ready, worker_pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        send(worker_pid, { :fib, next, self, length(queue) })
        schedule(worker_pids, tail, results)

      { :ready, worker_pid } ->
        send(worker_pid, { :shutdown })

        if length(worker_pids) > 1 do
          schedule(List.delete(worker_pids, worker_pid), queue, results)
        else
          results
          |> Enum.sort(fn {n1,_}, {n2,_} -> n1 >= n2 end)
          |> Enum.map(fn {_, result} -> result end)
        end

      { :answer, number, worker_result } ->
        schedule(worker_pids, queue, [{number, worker_result} | results])
    end
  end
end

# IO.inspect FibScheduler.run(2, [7, 3, 6])

to_process = List.duplicate(37, 20)

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(FibScheduler, :run, [num_processes, to_process])

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end

  :io.format "~2B   ~.2f~n", [num_processes, time/1000000.0]
end
