{ :ok, agent_pid } = Agent.start(fn -> 0 end)

# IO.inspect Agent.get(agent_pid, fn(state) -> state end)
# Agent.update(agent_pid, fn(state) -> state + 1 end)
# IO.inspect Agent.get(agent_pid, fn(state) -> state end)
#
# IO.inspect agent_pid

defmodule WordFrequency do
  def start_link do
    Agent.start(fn -> %{} end, name: __MODULE__)
  end

  def add_word(word) do
    Agent.update(__MODULE__, fn(words) -> Map.update(words, word, 1, &(&1+1)) end)
  end

  def word_count(word) do
    Agent.get(__MODULE__, fn(words) -> words[word] end)
  end

  def words do
    Agent.get(__MODULE__, fn(words) -> Map.keys(words) end)
  end
end

WordFrequency.start_link
WordFrequency.add_word "Toma"
WordFrequency.add_word "Toma"
IO.inspect WordFrequency.words
IO.inspect WordFrequency.word_count "Toma"
