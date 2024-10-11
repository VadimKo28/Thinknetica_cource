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
  attr_reader :route, :train, :trains

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
    puts "Придумайте номер поезда"

    number_train_input = gets.to_i

    puts "Укажите тип поезда: 0 - Пассажиский, 1 - Гузовой"

    type_train_input = gets.to_i

    @train = if type_train_input == 0
        @trains << PassengerTrain.new(number_train_input)
      elsif type_train_input == 1
        @trains << CargoTrain.new(number_train_input)
      else
        return puts "Некорректное значение, введите 0 или 1"
      end

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
    puts "Введите название станции которую нужно добавить"

    return puts "Создайте маршрут" if route.nil?

    route.add_intermediate_states(gets.chomp.to_s)
  end

  def remove_station
    puts "Введите название станции которую нужно убрать"

    route.remove_intermediate_states(gets.chomp.to_s)
  end

  def add_rout_to_train
    train.add_route(route)
  end

  def add_wagon_to_train
    puts "Создайте вагон. Для этого укажите его тип \n
         0 - грузовой\n
         1 - пассажирский"
    user_input = gets.to_i

    wagon = if user_input == 0
        CargoWagon.new
      elsif user_input == 0
        PassengerWagon.new
      else
        return "такого значения нет"
      end

    train.add_wagon(wagon)
  end

  def remove_wagon_to_train
    return "Нет вагонов у поезда" if train.wagons.empty?

    train.remove_wagon(train.wagons.last)
  end

  def move_train_to_route
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
    route.stations
  end

  def station_trains
    puts "Поезда какой станции хотите посмотреть? укажите цифру"
    route.stations.each_with_index do |station, index|
      puts "#{index} - #{station}"
    end

    route.stations[gets.to_i].trains
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
