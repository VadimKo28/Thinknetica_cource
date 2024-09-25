puts "Введите a, PS: недолжен быть равен 0"
a = gets.to_f

return puts "Повторяю, a не должен быть равен 0, попробуйте заново" if a == 0

puts "Введите b"
b = gets.to_f

puts "Введите c"
c = gets.to_i

d = (b**2 - (4*a*c))

if d > 0 
  x1 = (-b + Math.sqrt(d))/2*a
  x2 = (-b - Math.sqrt(d))/2*a
  puts "Дискриминант равен #{d}, корней два: x1 - #{x1} и x2 - #{x2}"
elsif d == 0 
  x = -b/(2*a)
  puts "Дискриминант равен #{d}, один корень: x - #{x}"
else
  puts "Дискриминант равен #{d}, корней нет"
end