puts "Введите сторону a"
a = gets.to_i

puts "Введите сторону b"
b = gets.to_i

puts "Введите сторону c"
c = gets.to_i

sort_sides = [a,b,c].sort 

if a == b && b == c && a == c
  puts "Треугольник равносторонний"
elsif sort_sides[1] == sort_sides[2]  
  puts "Треугольник равнобедренный"
elsif sort_sides[0]**2 == sort_sides[1]**2 + sort_sides[2]**2
  puts "Треугольник прямоугольный или равнобедренный"
end


