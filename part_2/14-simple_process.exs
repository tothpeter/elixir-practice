defmodule Spawn1 do
  def greet do
    receive do
      {sender, ""} -> send sender, { :error, "empty message" }
      {sender, msg} -> send sender, { :ok, "Hello, #{msg}" }
      greet
    end
  end
end

# Client
pid = spawn(Spawn1, :greet, [])
send pid, {self, "World!"}

receive do
  {:ok, message} -> IO.puts message
  {:error, message} -> IO.puts "Error: #{message}"
end

send pid, {self, ""}

receive do
  {:ok, message} -> IO.puts message
  {:error, message} -> IO.puts "Error: #{message}"
  after 500 ->
    IO.puts "The greeter has gone away"
end
