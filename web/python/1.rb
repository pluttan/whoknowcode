strings = ["one", "two", "four", "five"]
sum = 0
strings.inject(0) do |sum, str|
  sum += str.size if str.size != 4
end
puts sum
