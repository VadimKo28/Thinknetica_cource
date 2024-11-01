class CargoWagon < Wagon
  attr_reader :type

  attr_accessor :volume_count, :taked_volumes

  def initialize(volume_count)
    @volume_count = volume_count
    @type = 'cargo'
    @taked_volumes = 0
    validation!
  end

  def take_volume(volume)
    self.volume_count -= volume
    self.taked_volumes += volume
  end

  private

  def validation!
    raise StandardError, 'У вагона не может быть 0 объём грузового вагона' if volume_count.to_i <= 0

    true
  end
end
