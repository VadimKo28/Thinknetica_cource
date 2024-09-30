class Route 
  attr_reader :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
  end

  def add_intermediate_states(station)
    @intermediate_stations << station
    puts "Добавлена промежуточная станция #{station}"
  end

  def delete_intermediate_station(station)
    @intermediate_stations.delete(station)
    puts "Станция #{station.name} удалена"
  end

  def get_all_stations
    [start_station, @intermediate_stations, end_station].flatten
  end
end
