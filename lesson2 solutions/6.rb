nested_result = {}

total_result = {} 

total_price = 0.0

loop do 

  puts "Введите название товара. Для выхода введите 0"
  title = gets.to_s.chomp 

  break if title == "0"

  puts "Введите цену товара"
  price = gets.to_i

  puts "Введите колличество товара" 
  count = gets.to_f

  nested_result[:price] = price  
  nested_result[:count] = count 

  total_result[title] = nested_result
  total_price += price * count

  puts "#{{title => nested_result}} - цена #{price * count}"
end


puts total_result
puts "Итоговая сумма #{total_price}"
