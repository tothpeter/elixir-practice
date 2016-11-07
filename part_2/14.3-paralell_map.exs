defmodule ParallelMap do
  def run(collection, fun) do
    me = self
    collection
    |> Enum.map(fn(item) ->
      spawn_link fn -> send(me, { self, fun.(item) }) end
    end)
    |> Enum.map(fn(pid) ->
      receive do {^pid, result} -> result end
    end)
  end
end

IO.inspect ParallelMap.run [1,2,3], fn item -> item * 2 end
