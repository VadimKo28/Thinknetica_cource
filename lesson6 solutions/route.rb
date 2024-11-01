class Route
  include InstanceCounter

  @objects = []

  attr_reader :start_station, :end_station, :intermediate_stations

  def self.all
    @objects
  end

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
    self.class.all << self
  end

  def add_intermediate_stations(station)
    @intermediate_stations << station
  end

  def delete_intermediate_stations(station)
    @intermediate_stations.delete(station)
  end

  def stations
    [start_station, @intermediate_stations, end_station].flatten
  end
end
