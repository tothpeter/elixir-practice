prefix = fn s ->
  fn s2 ->
    "#{s} #{s2}"
  end
end

mrs = prefix.("Mrs")

IO.puts mrs.("Smith")
IO.puts prefix.("Elixir").("Rocks")


# Enum.map [1,2,3,4], &(&1 + 2)
# Enum.each [1,2,3,4], &IO.inspect/1
