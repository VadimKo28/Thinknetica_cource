class PassengerWagon < Wagon
  attr_reader :type
  attr_accessor :place_count, :taked_places

  def initialize(place_count)
    @place_count = place_count
    @type = 'passenger'
    @taked_places = 0
    validation!
  end

  def take_place
    self.place_count -= 1
    self.taked_places += 1
  end

  private

  def validation!
    raise StandardError, 'У вагона не может быть 0 мест' if place_count.to_i <= 0

    true
  end
end
