class Route 
  attr_reader :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_states = []
  end

  def add_intermediate_states(state)
    @intermediate_states << state
    puts "Добавлена промежуточная станция #{state}"
  end

  def delete_intermediate_states(state)
    @intermediate_states.delete(state)
    puts "Станция #{state.name} удалена"
  end

  def get_all_states
    result = []

    result << start_station

    @intermediate_states.each {|intermediate_states| result << intermediate_states}

    result << end_station

    result
  end
end