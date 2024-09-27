puts "Введите число" 
day = gets.to_i

puts "Введите месяц"
month = gets.to_i - 1

puts "Введите год"
year = gets.to_i 

month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

month_leap_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]


if day > month_days[month] && day > month_leap_days[month]
  puts "В этом месяце не может быть #{day} дней"
elsif (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
  puts "Порядковый номер даты #{month_days[0] + month_days[month] - (month_days[month] - day )}"
else
  puts "Порядковый номер даты #{month_leap_days[0] + month_leap_days[month] - (month_leap_days[month] - day)}" 
end
