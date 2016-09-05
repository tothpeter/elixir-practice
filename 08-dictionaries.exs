defmodule Sum do
  def values(dict) do
    dict |> Dict.values |> Enum.sum
  end
end

# hd = [ one: 1, two: 2, three: 3 ] |> Enum.into(HashDict.new)
# IO.puts Sum.values(hd)

people = [
  %{ name: "Grumpy",    height: 1.24 },
  %{ name: "Dave",      height: 1.88 },
  %{ name: "Dopey",     height: 1.32 },
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Sneezy",    height: 1.28 }
]

# for person = %{ height: height } <- people,
#     height > 1.5,
#     do: IO.inspect person


defmodule HotelRoom do
  def book(%{ name: name, height: height })
  when height > 1.9 do
    IO.puts "Large for #{name}"
  end

  def book(%{ name: name, height: height })
  when height < 1.3 do
    IO.puts "Small for #{name}"
  end

  def book(person) do
    IO.puts "Normal for #{person.name}"
  end
end

# people |> Enum.each(&HotelRoom.book(&1))

authors = [
  %{ name: "JosÃ©",  language: "Elixir" },
  %{ name: "Matz",  language: "Ruby" },
  %{ name: "asd",  language: "asd" },
  %{ name: "Larry", language: "Perl" }
]

languages_with_an_r = fn (:get, collection, next_fn) ->
  for row <- collection do
    if String.contains?(row.language, "r")  do
      next_fn.(row)
    end
  end
end

IO.inspect get_in(authors, [languages_with_an_r, :name])
