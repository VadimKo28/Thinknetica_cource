puts "Назовите ваше имя"

name = gets.chomp

puts "Укажите ваш рост в см"

height = gets.to_i

result = (height - 110) * 1.15

if result < 0
  puts "#{name}, ваш вес уже оптимальный"
else 
  puts "#{name}, ваш вес #{result}"
end