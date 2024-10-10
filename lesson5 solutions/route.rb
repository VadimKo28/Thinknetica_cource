class Route 
  @objects = []

  include InstanceCounter

  attr_reader :start_station, :end_station

  def self.all
    @objects
  end

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
    self.class.all << self 
  end

  def add_intermediate_states(station)
    @intermediate_stations << station
    puts "Добавлена промежуточная станция #{station}"
  end

  def delete_intermediate_station(station)
    @intermediate_stations.delete(station)
    puts "Станция #{station.name} удалена"
  end

  def stations
    [start_station, @intermediate_stations, end_station].flatten
  end
end
