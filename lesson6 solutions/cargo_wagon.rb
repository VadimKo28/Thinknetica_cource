class CargoWagon < Wagon
  include Validation

  attr_reader :type
  attr_accessor :volume_count, :taked_volumes
  validate :volume_count, :presence

  validate :volume_count, :type, Integer

  def initialize(volume_count)
    @volume_count = volume_count
    @type = 'cargo'
    @taked_volumes = 0
    validate!
  end

  def take_volume(volume)
    self.volume_count -= volume
    self.taked_volumes += volume
  end
end
