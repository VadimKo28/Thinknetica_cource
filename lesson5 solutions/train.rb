class Train 
  @objects = []
  
  include ManufacturedCompany
  include InstanceCounter

  attr_reader :number

  def self.find(number)
    @objects.find {|train| train.number == number}
  end

  def self.all
    @objects
  end

  def initialize(number)
    @current_speed = 0
    @route = nil
    @wagons = []
    @number = number
    self.class.all << self 
    register_instance
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    current_station.accept_trains(self)
  end

  def add_wagon(wagon)
    wagons << wagon
    puts "Вагон присоединён"
  end   

  def remove_wagon(wagon)
    return puts "Этого вагона нет у поезда" unless wagons.include?(wagon)
    wagons.delete(wagon)
    puts "Вагон отсоединён"
  end

  def up_one_station
    return unless next_station

    current_station.send_train(self)

    @current_station_index += 1
   
    current_station.accept_trains(self)
  end

  def down_one_station
    return unless previous_station

    current_station.send_train(self)
    
    @current_station_index -= 1

    current_station.accept_trains(self)
  end

  # Делаем wagons доступным только в подклассах, извне не используем(по крайней мере в условии про это не сказано)
  protected
  attr_reader :wagons

  # Все методы ниже пользовательским интерфейсом пока не используются
  private    
  attr_reader :route
  attr_accessor :current_speed, :current_station_index

  def up_speed(accelerate)
    self.current_speed += accelerate
  end

  def break
    self.current_speed = 0
  end

  def current_station
    route.stations[current_station_index] unless route.nil?
  end

  def next_station
    route.stations[current_station_index + 1] 
  end

  def previous_station
    return puts "Предыдущей станции нет" if current_station_index == 0
    route.stations[current_station_index - 1] 
  end
end
