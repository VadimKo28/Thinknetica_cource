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
require 'byebug'

class Interface
  ACTIONS = {
        1 => "create_station", 2 => "create_train", 3 => "create_route", 4 => "add_station",
        5 => "remove_station", 6 => "add_rout_to_train", 7 => "add_wagon_to_train",
        8 => "remove_wagon_to_train", 9 => "move_train_to_route", 10 => "route_stations", 11 => "station_trains",
        12 => "search_train", 13 => "all_stations", 14 => "set_manufactured_train", 15 => "get_manufactured_train",
        16 => "take_place", 17 => "take_volume", 18 => "fetch_all_train", 19 => "fetch_all_wagons",
        0 => "exit"
      }

  attr_reader :route, :trains

  def initialize
    @trains = []
    @stations = []
  end

  def choose_user(print_interface)

    loop do
      puts print_interface

      user_input = gets.to_i

      eval(ACTIONS[user_input])

      break if user_input == 0
    end

    return "Вы вышли"
  end

  private

  def create_station
    puts "Введите название станции русскими буквами, не менее 3х символов"

    name_station = gets.chomp.to_s

    @stations << Station.new(name_station)

    puts "Станция #{name_station} создана"

  rescue StandardError => e 
    puts "Exception #{e.message}\n"
    
    retry
  end

  def create_train    
    message = <<~MESSAGE 
                Введите № поезда
                Три буквы или цифры в любом порядке,
                необязательный дефис (может быть, а может нет)
                и еще 2 буквы или цифры после дефиса
              MESSAGE

    puts message          

    number_train_input = gets.chomp.to_s

    puts "Укажите тип поезда: 0 - Пассажиский, 1 - Гузовой"

    type_train_input = gets.to_i

    train_type = { 
      0 => PassengerTrain.new(number_train_input), 
      1 => CargoTrain.new(number_train_input) 
    }
   
    train = train_type[type_train_input]

    return puts "Некорректное значение, введите 0 или 1" if train.nil?

    @trains << train 

    puts "Поезд создан"

  rescue StandardError => e 
    puts "Exception #{e.message}(Невалидное название для поезда)\n"
    
    retry
  end

  def create_route
    message = <<~MESSAGE
                Для создания маршрута нужны начальная и конечная станции
                Введите название для начальной, P.S. только русскими буквами
              MESSAGE

    puts message      

    start_station = Station.new(gets.chomp.to_s)

    @stations << start_station

    puts "Теперь введите название конечной станции, P.S. только русскими буквами"

    end_station = Station.new(gets.chomp.to_s)

    @stations << end_station

    @route = Route.new(start_station, end_station)

    puts "Маршрут со станциями #{route.stations} создан"
  end

  def add_station
    puts "Введите название промежуточной станции которую нужно добавить"

    station_name = gets.chomp.to_s

    return puts "Создайте маршрут" if route.nil?

    station = Station.new(station_name)

    route.add_intermediate_stations(station)

    puts "Добавлена промежуточная станция #{station}"
  end

  def remove_station
    puts "Убрать можно только промежуточную станцию, введите название"

    name_station = gets.chomp.to_s
    
    find_station = route.intermediate_stations.find {|station| station.name == name_station}

    return puts "Такой станции нет" if find_station.nil?

    route.delete_intermediate_stations(find_station)

    "Станция #{find_station.name} удалена"
  end

  def add_rout_to_train
    puts "Введите № поезда которому добавить маршрут"

    number_train = gets.chomp.to_s 

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
        create_cargo_wagon
      when 1
        create_passenger_wagon
      else
        return "такого значения нет"
      end

    puts "Введите номер поезда которому хотите прицепить вагон"

    number_train = gets.chomp.to_s

    train = find_train(number_train)

    return puts "Нет такого поезда" if train.nil?  

    train.add_wagon(wagon)
  end

  def remove_wagon_to_train
    return "Нет вагонов у поезда" if train.wagons.empty?

    train.remove_wagon(train.wagons.last)

    puts "Вагон отсоединён"
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

    case user_input
    when 0
      train.up_one_station
    when 1
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
    all_stations = Station.all

    return puts "Станций нет" if all_stations.empty?

    puts "Поезда какой станции хотите посмотреть? укажите цифру"

    number_variant_user = gets.to_i

    all_stations.each_with_index do |station, index|
      puts "#{index} - #{station}"
    end

    puts "Поезда станции - #{all_stations[number_variant_user].trains}"
  end

  def search_train
    puts "Введите номер поезда"

    number_train = gets.chomp.to_s

    train = find_train(number_train)

    puts train.nil? ? nil : "Поезд найден #{train}"
  end

  def all_stations
    puts "Все станции - #{Station.all}" 
    puts
  end  

  def set_manufactured_train
    puts "Введите номер поезда которому установить производителя" 

    number_train = gets.chomp.to_s

    train = find_train(number_train)

    return puts "Нет такого поезда" if train.nil?  

    puts "Введите название производителя"

    manufactured_name = gets.chomp.to_s

    train.set_company_name(manufactured_name)

    puts "Готово"
  end

  def get_manufactured_train
    puts "Введите номер поезда производителя которого показать" 

    number_train = gets.chomp.to_s 

    train = find_train(number_train)

    return puts "Нет такого поезда" if train.nil?  

    puts "Поезд #{train} производства - #{train.print_company_name}"
  end

  def take_place
    puts "Введите номер поезда в вагоне которого занять место" 

    number_train = gets.chomp.to_s 

    train = find_pasenger_train(number_train)

    return puts "У этого поезда нет пассажирских вагонов, или нет такого поезда" if train.wagons.empty? || train.nil?  

    train.wagons.first.take_place

    puts "Место в вагоне занято"
  end

  def take_volume
    puts "Введите номер поезда в вагоне которого занять объём" 

    number_train = gets.chomp.to_s 

    train = find_cargo_train(number_train)
    
    return puts "У этого поезда нет грузовых вагонов, или нет такого поезда" if train.nil? || train.wagons.empty?

    puts "Какой кубический объём груза вам занять?"

    volume = gets.to_i

    train.wagons.first.take_volume(volume)

    puts "В вагоне занято #{volume} кубаметра"
  end

  def find_pasenger_train(number_train)
    train = find_train(number_train) 

    return puts "Это не пассажирский поезд, у него нельзя занять место в вагоне" if train.class == CargoTrain

    train
  end

  def find_cargo_train(number_train)
    train = find_train(number_train) 

    return puts "Это не грузовой поезд, у него нельзя занять объём в вагоне" if train.class == PassengerTrain

    train
  end

  def find_train(number_train)
    @trains.find do |train|
      train.class.find(number_train)
    end 
  end

  def find_station(input_name)
    @stations.find { |station| station.name == input_name }
  end

  def create_passenger_wagon
    begin 
      puts "Введите колличество мест в вагоне"

      place_count = gets.to_i
      
      PassengerWagon.new(place_count)
    rescue StandardError => e 
      puts e.message

      retry
    end
  end

  def create_cargo_wagon
    begin 
      puts "Введите колличество кубаметров объёма вагона"
    
      volume_count = gets.to_i
    
      CargoWagon.new(volume_count)
    rescue StandardError => e 
      puts e.message

      retry
    end
  end

  def fetch_all_train
    puts "Введите название станции, поезда которой показать"

    input_name = gets.chomp.to_s

    station = find_station(input_name)

    puts "Поезда станции #{station.name}"

    puts station.all_trains
  end

  def fetch_all_wagons
    puts "Введите № поезда, вагоны которого показать"

    number_train = gets.chomp.to_s

    train = find_train(number_train)

    return puts "Нет такого поезда" if train.nil?

    puts "Вагоны"
    
    puts train.all_wagons
  end
end
