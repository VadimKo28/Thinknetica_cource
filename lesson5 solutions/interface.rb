require_relative "manufactured_company.rb"
require_relative "instance_counter.rb"
require_relative "station.rb"
require_relative "route.rb"
require_relative "train.rb"
require_relative "cargo_train.rb"
require_relative "passenger_train.rb"
require_relative "wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "passenger_wagon.rb"

class Interface
  attr_reader :route, :trains

  def initialize
    @trains = []
  end

  def choose_user(print_interface)

    loop do
      puts print_interface

      user_input = gets.to_i

      actions = {
        1 => "create_station", 2 => "create_train", 3 => "create_route", 4 => "add_station",
        5 => "remove_station", 6 => "add_rout_to_train", 7 => "add_wagon_to_train",
        8 => "remove_wagon_to_train", 9 => "move_train_to_route", 10 => "route_stations", 11 => "station_trains",
        12 => "search_train", 13 => "all_stations", 14 => "set_manufactured_train", 15 => "get_manufactured_train",
        0 => "exit"
      }

      eval(actions[user_input])

      break if user_input == 0
    end

    return puts "Вы вышли"
  end

  private

  def create_station
    puts "Введите название станции"

    name_station = gets.chomp.to_s

    Station.new(name_station)

    puts "Станция #{name_station} создана"
    puts
  end

  def create_train
    puts "Введите № поезда цифрами"

    number_train_input = gets.to_i

    puts "Укажите тип поезда: 0 - Пассажиский, 1 - Гузовой"

    type_train_input = gets.to_i

    train = case type_train_input
    when 0
      PassengerTrain.new(number_train_input)
    when 1
      CargoTrain.new(number_train_input)
    else
      return puts "Некорректное значение, введите 0 или 1"
    end

    @trains << train 

    puts "Поезд создан #{train}"
  end

  def create_route
    puts 'Для создания маршрута нужны начальная и конечная станции\
          Введите название для начальной'

    start_station = Station.new(gets.chomp.to_s)

    puts "Теперь введите название конечной станции"

    end_station = Station.new(gets.chomp.to_s)

    @route = Route.new(start_station, end_station)

    puts "Маршрут со станциями #{route.stations} создан"
  end

  def add_station
    puts "Введите название промежуточной станции которую нужно добавить"

    station_name = gets.chomp.to_s

    return puts "Создайте маршрут" if route.nil?

    station = Station.new(station_name)

    route.add_intermediate_stations(station)
  end

  def remove_station
    puts "Убрать можно только промежуточную станцию, введите название"

    name_station = gets.chomp.to_s
    
    find_station = route.intermediate_stations.find {|station| station.name == name_station}

    return puts "Такой станции нет" if find_station.nil?

    route.delete_intermediate_stations(find_station)
  end

  def add_rout_to_train
    puts "Введите № поезда которому добавить маршрут"

    number_train = gets.to_i 

    train = find_train(number_train)

    return puts "Такого поезда нет" if train.nil?

    train.add_route(route)

    puts "Маршрут добавлен"
  end

  def add_wagon_to_train
    puts "Создайте вагон. Для этого укажите его тип \n
         0 - грузовой\n
         1 - пассажирский"
    wagon_type = gets.to_i

    wagon = case wagon_type 
      when 0
        CargoWagon.new
      when 1
        PassengerWagon.new
      else
        return "такого значения нет"
      end

    puts "Введите номер поезда которому хотите прицепить вагон"

    number_train = gets.to_i 

    train = find_train(number_train)

    return puts "Нет такого поезда" if train.nil?  

    train.add_wagon(wagon)
  end

  def remove_wagon_to_train
    return "Нет вагонов у поезда" if train.wagons.empty?

    train.remove_wagon(train.wagons.last)
  end

  def move_train_to_route
    puts 'Какой поезд хотите переместить, введите номер'

    number_train = gets.to_i 

    train = find_train(number_train)

    return puts "Такого поезда нет" if train.nil?

    puts 'Переместить поезд по маршруту:\
          0 - На станцию вперёд\
          1 - На станцию назад'
    user_input = gets.to_i

    if user_input == 0
      train.up_one_station
    elsif user_input == 1
      train.down_one_station
    else
      return "Такого значения нет"
    end
  end

  def route_stations
    return puts "Маршрут отсутствует" if route.nil?
    puts "Станции маршрута #{route.stations}"
  end

  def station_trains
    puts "Поезда какой станции хотите посмотреть? укажите цифру"

    all_stations = Station.all

    number_variant_user = gets.to_i

    return puts "Станций нет" if all_stations.empty?

    all_stations.each_with_index do |station, index|
      puts "#{index} - #{station}"
    end

    puts "Поезда станции - #{all_stations[number_variant_user].trains}"
  end

  def search_train
    puts "Введите номер поезда"

    number_train = gets.to_i

    train = find_train(number_train)

    p train.nil? ? nil : "Поезд найден #{train}"
  end

  def all_stations
    puts "Все станции - #{Station.all}" 
    puts
  end  

  def set_manufactured_train
    puts "Введите номер поезда которому установить производителя" 

    number_train = gets.to_i 

    train = find_train(number_train)

    return puts "Нет такого поезда" if train.nil?  

    puts "Введите название производителя"

    manufactured_name = gets.chomp.to_s

    train.set_company_name(manufactured_name)

    puts "Готово"
  end

  def get_manufactured_train
    puts "Введите номер поезда производителя которого показать" 

    number_train = gets.to_i 

    train = find_train(number_train)

    return puts "Нет такого поезда" if train.nil?  

    puts "Поезд #{train} производства - #{train.print_company_name}"
  end

  def exit
    return "Вы вышли"
  end

  private 

  def find_train(number_train)
    @trains.find do |train|
      train.class.find(number_train)
    end 
  end
end
