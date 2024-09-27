hi_board = 100

first, second = 0, 1

result = []

while first <= hi_board
  result << first
  sum = first + second
  first = second
  second = sum
  
end

puts result
