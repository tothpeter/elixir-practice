
# output1 = for x <- [1,2,3,4,5,6], x < 4, do: x
# IO.inspect output1

output2 = for x <- [1,2], y <- [3,4], x < 4, do: x * y
IO.inspect output2
