Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
  |> Enum.take(7)
  # |> IO.inspect

defmodule FileUtil do
  def read(path) do
    Stream.resource(
      fn -> File.open!(path) end,
      fn file ->
        case IO.read(file, :line) do
          line when is_binary(line) -> { [line], file }
          _ -> {:halt, file}
        end
      end,
      fn file -> File.close(file) end
    )
  end
end

# lines = FileUtil.read("test_file")
# Enum.each(lines, &IO.inspect(&1))


defmodule Countdown do
  def sleep(seconds) do
    receive do
      after seconds * 1000 -> nil
    end
  end

  def say(text) do
    spawn fn -> :os.cmd('say #{text}') end
  end

  def timer do
    Stream.resource(
    fn ->
      {_h, _n, s} = :erlang.time
      60 - s - 1
    end,
    fn
      0 -> {:halt, 0}
      count ->
        sleep(1)
        # { [IO.inspect(count)], count - 1 }
        { [count], count - 1 }
    end,
    fn _ -> nil end)
  end
end

# counter = Countdown.timer

# counter
  # |> Enum.take(5)
  # |> Enum.each(&IO.inspect(&1))
  # |> Enum.to_list

# printer = Stream.each(counter, &IO.inspect(&1))
# speaker = Stream.each(printer, &Countdown.say(&1))

# Enum.take(speaker, 5)
# Enum.to_list(speaker)


# File.read!("test_file")
#   |> String.split
#   |> Enum.max_by(&String.length/1)
#   |> IO.inspect
#
# File.open!("test_file")
#   |> IO.stream(:line)
#   |> Enum.max_by(&String.length/1)
#   |> IO.inspect

# File.stream!("test_file")
#   |> Enum.max_by(&String.length/1)
#   |> IO.inspect

# Stream.map(1..10_000_000, &(&1+1))
#   |> Enum.take(5)
#   |> IO.inspect

# Stream.cycle(~w( white black ))
#   |> Stream.zip(1..5)
#   |> Enum.map(fn {color, number} -> ~s(<td class="#{color}">#{number}</td>) end)
#   |> IO.inspect

# Stream.repeatedly(&:random.uniform/0)
#   |> Enum.take(3)
#   |> IO.inspect

# Stream.iterate(0, &(&1+1))
#   |> Enum.take(5)
#   |> IO.inspect

Stream.unfold({0, 1}, fn {f1, f2} -> {f1, {f2, f1+f2}} end)
  |> Enum.take(15)
  |> IO.inspect
