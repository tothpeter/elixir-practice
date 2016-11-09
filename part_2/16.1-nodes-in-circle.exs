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
      { :register, pid } ->
        first_client = List.first(clients) || pid
        last_client = List.last(clients) || pid

        send pid, { :new_next_client, first_client }
        send last_client, { :new_next_client, pid }

        if length(clients) == 0, do: send pid, { :tick }

        generator(clients ++ [pid])
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [nil])
    Ticker.register(pid)
  end

  def receiver(next_client) do
    receive do
      { :tick } ->
        IO.puts "Tock in client #{inspect self}"
        :timer.sleep(1000 * 2)
        send next_client, { :tick }
        receiver next_client
      { :new_next_client, new_next_client } ->
        receiver new_next_client
    end
  end
end

Ticker.start
Client.start

:timer.sleep(1000 * 2)
Client.start

:timer.sleep(1000 * 2)
Client.start

receive do

end
# Ticker.register self
