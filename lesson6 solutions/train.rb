class Train
  include ManufacturedCompany
  include InstanceCounter
  extend Accessors

  NUMBER_TRAIN_FORMAT = /^[А-Яа-яA-Za-z0-9]{3}-?[А-Яа-яA-Za-z0-9]{2}$|^([A-Za-z0-9]{5})$/

  @objects = []

  attr_accessor_with_history :number
  attr_reader :wagons

  class << self
    def find(number)
      @objects.find { |train| train.number == number }
    end

    def all
      @objects
    end
  end

  def initialize(number)
    @current_speed = 0
    @route = nil
    @wagons = []
    @number = number.to_s
    validate!
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
    puts 'Вагон добавлен'
  end

  def remove_wagon(wagon)
    wagons.delete(wagon)
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

  def valid?
    validate!
  rescue StandardError
    false
  end

  def all_wagons
    @wagons.each do |wagon|
    end
  end

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
    return puts 'Предыдущей станции нет' if current_station_index == 0

    route.stations[current_station_index - 1]
  end

end
