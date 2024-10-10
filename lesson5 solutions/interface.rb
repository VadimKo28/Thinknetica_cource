require_relative 'manufactured_company.rb'
require_relative 'instance_counter.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'



class Interface 
  attr_reader :route, :train

  def choose_user(user_input) 
    actions = {
      1 => 'create_station', 2 => 'create_train', 3 => 'create_route', 4 => 'add_station',
      5 => 'remove_station', 6 => 'add_rout_to_train', 7 => 'add_wagon_to_train',
      8 => 'remove_wagon_to_train', 9 => 'move_train_to_route', 10 => 'route_stations', 11 => 'station_trains',
      0 => 'exit'
    } 

    eval(actions[user_input])

    #Сильно зашкварно использовать здесь eval?
    #Если да, тогда перепишу в этом методе всё на case вместо хэша и eval
  end

  private

  def create_station
    puts 'Введите название станции'
    
    Station.new(gets.chomp.to_s )
  end

  def create_train
    puts 'Придумайте номер поезда'

    number_train_input = gets.to_i

    puts 'Укажите тип поезда: 0 - Пассажиский, 1 - Гузовой'

    type_train_input = gets.to_i

    @train = if type_train_input == 0
      PassengerTrain.new(number_train_input)
    elsif type_train_input == 0  
      CargoTrain.new(number_train_input)
    else
      return puts 'Некорректное значение, введите 0 или 1'
    end  

    puts "Поезд создан #{train}"
  end

  def create_route
    puts 'Для создания маршрута нужны начальная и конечная станции\
          Введите название для начальной'

    start_station = Station.new(gets.chomp.to_s) 

    puts 'Теперь введите название конечной станции'

    end_station = Station.new(gets.chomp.to_s) 

    @route = Route.new(start_station, end_station)
    
    puts "Маршрут со станциями #{route.stations} создан"
  end

  def add_station
    puts 'Введите название станции которую нужно добавить'

    route.add_intermediate_states(gets.chomp.to_s)
  end

  def remove_station
    puts 'Введите название станции которую нужно убрать'

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
      return 'такого значения нет'
    end

    train.add_wagon(wagon)
  end

  def remove_wagon_to_train
    return 'Нет вагонов у поезда' if train.wagons.empty?

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
      return 'Такого значения нет'
    end     
  end

  def route_stations 
    route.stations
  end

  def station_trains
    puts 'Поезда какой станции хотите посмотреть? укажите цмфру'
    route.stations.each_with_index do |station, index|
      puts "#{index} - #{station}"
    end

    route.stations[gets.to_i].trains
  end

  def exit
    return
  end 
end
