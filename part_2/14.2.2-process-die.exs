defmodule ProcLink do
  import :timer, only: [ sleep: 1 ]

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(ProcLink, :sad_fn, [])

    receive do
      msg ->  IO.puts "Message: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing"
    end
  end

  def sad_fn do
    sleep(500)
    exit(:boom)
  end
end

ProcLink.run
