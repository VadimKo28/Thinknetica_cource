require_relative 'interface.rb'

puts "Выберите действие:\n
      1. Создать станцию\n
      2. Создать поезд\n
      3. Создать маршрут\n
      4. Добавить станцию в маршруте\n
      5. Удалить станцию с маршрута\n
      6. Назначить маршрут поезду\n
      7. Добавить вагон к поезду\n
      8. Отцепить вагон от поезда\n
      9. Переместить поезд по маршруту\n
      10. Просмотреть список станций\n
      11. Просмотреть список поездов на станции\n
       0. Выход"

user_input = gets.chomp.to_i

interface = Interface.new 

interface.choose_user(user_input)
