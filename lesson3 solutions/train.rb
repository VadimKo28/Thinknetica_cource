class Train 
  attr_reader :route
  attr_accessor :current_speed, :current_station_index, :count_train_units

  def initialize(number, type, count_train_units)
    @number = number 
    @type = type 
    @count_train_units = count_train_units
    @current_speed = 0
    @route = nil
  end

  def up_speed(accelerate)
    self.current_speed += accelerate
  end

  def get_current_speed
    current_speed
  end

  def break
    self.current_speed = 0
  end

  def train_units
    @count_train_units     
  end 

  def add_train_units
    self.count_train_units += 1 if current_speed == 0
  end

  def remove_train_units
    self.count_train_units -= 1 if current_speed == 0
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
    current_station.accept_trains(self)
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

  def current_station
    route.stations[current_station_index] 
  end

  def next_station
    route.stations[current_station_index + 1] 
  end

  def previous_station
    return puts "Предыдущей станции нет" if current_station_index == 0
    route.stations[current_station_index - 1] 
  end
end
