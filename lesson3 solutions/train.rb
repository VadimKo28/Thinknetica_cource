class Train 
  attr_reader :route
  attr_accessor :current_speed, :current_state_index, :count_train_units

  def initialize(number, type, count_train_units)
    @number = number 
    @type = type 
    @count_train_units = count_train_units
    @current_speed = 0
    @route = nil
    @current_state_index = 0
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
    first_state_route = route.get_all_states[0] 
    first_state_route.accept_trains(self)
  end

  def up_one_station
    old_state = route.get_all_states[current_state_index]
    old_state.send_train(self)
    self.current_state_index += 1
    new_state = route.get_all_states[current_state_index]
    new_state.accept_trains(self)
  end

  def down_one_station
    old_state = route.get_all_states[current_state_index]
    old_state.send_train(self)
    self.current_state_index -= 1
    new_state = route.get_all_states[current_state_index]
    new_state.accept_trains(self)
  end

  def current_state
    route.get_all_states[current_state_index] 
  end

  def next_state
    route.get_all_states[current_state_index + 1] 
  end

  def previous_state
    route.get_all_states[current_state_index - 1] 
  end
end