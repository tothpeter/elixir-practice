defmodule Ticker do
  @interval 2000
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])

    :global.register_name(@name, pid)
  end

  def register(client) do
    send :global.whereis_name(@name), { :register, client }
  end

  def generator(clients) do
    receive do
      { :register, pid } -> generator([ pid | clients ])
    after @interval ->
        IO.puts "Tick"
        Enum.each clients, fn client ->
          send client, { :tick }
        end
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "Tock in client"
        receiver
    end
  end
end

# Ticker.start
# Client.start
# Ticker.register self
