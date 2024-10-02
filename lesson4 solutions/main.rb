require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'station.rb'
require_relative 'route.rb'


# puts 'Предлагаем вашему внимаю консольный симулятор жд станции \
#       Давайте начнём попорядку, создадим маршрут, для этого нужно создать две станции \
#       начальную и конечную \ 
#       Введите название начальной станции'

# start_station_input = gets.chomp.to_s 

# start_station = Station.new(start_station_input)

# puts 'Теперь ведите название конечной станции'

# end_station_input = gets.chomp.to_s 

# end_station = Station.new(end_station_input)

# route = Route.new(start_station, end_station)

# puts 'Отлично, две станции и маршрут созданы'

# puts 'Теперь нужно создать поезд. Придумайте номер поезда'

# number_train_input = gets.to_i

# puts 'Укажите тип поезда: 0 - Пассажиский, 1 - Гузовой'

# type_train_input = gets.to_i

# train = if type_train_input == 0
#   PassengerTrain.new(number_train_input)
# elsif type_train_input == 0  
#   CargoTrain.new(number_train_input)
# else
#   return puts 'Некорректное значение, введите 0 или 1'
# end  

# # Возможно спроектировать всё так, чтоб спрашивать ввод от пользователя в цикле
# # to be contined...   