defmodule Dictionary do
  @name __MODULE__
  # @name {:global, __MODULE__}

  # Public API

  def start_link do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def add_words(words) do
    Agent.update(@name, &do_add_words(&1, words))
  end

  def anagrams_of(word) do
    Agent.get(@name, &Map.get(&1, signature_of(word)))
  end

  # External implementation

  defp do_add_words(dictionary, words) do
    Enum.reduce(words, dictionary, &add_new_word(&2, &1))
  end

  defp add_new_word(dictionary, word) do
    Map.update(dictionary, signature_of(word), [word], fn(word_list) -> [word | word_list] end)
  end

  defp signature_of(word) do
    word |> to_charlist |> Enum.sort |> to_string
  end
end

# Dictionary.start_link
# Dictionary.add_words(["asd", "dsa", "toma", "ads", "amot"])
# IO.inspect Dictionary.anagrams_of("asd")
# IO.inspect Dictionary.anagrams_of("toma")

defmodule WordlistLoader do
  def load_from_files(file_names) do
    file_names
    |> Stream.map(fn(file_name) -> Task.async(fn -> load_task(file_name) end) end)
    |> Enum.each(&Task.await(&1))
  end

  defp load_task(file_name) do
    File.stream!(file_name, [], :line)
    |> Enum.map(&String.strip(&1))
    |> Dictionary.add_words
  end
end

Dictionary.start_link

Enum.map(1..4, &"part_2/word_list#{&1}")
|> WordlistLoader.load_from_files

IO.inspect Dictionary.anagrams_of "organ"
# IO.inspect Agent.get(Dictionary, &(&1))
