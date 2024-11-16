class PassengerWagon < Wagon
  include Validation

  attr_reader :type
  attr_accessor :place_count, :taked_places
  
  validate :place_count, :presence
  
  validate :place_count, :type, Integer

  def initialize(place_count)
    @place_count = place_count
    @type = 'passenger'
    @taked_places = 0
    validate!
  end

  def take_place
    self.place_count -= 1
    self.taked_places += 1
  end
end
