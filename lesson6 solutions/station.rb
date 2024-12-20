class Station
  include InstanceCounter
  include Validation

  NAME_FORMAT = /^([А-Яа-яЁё]{3,})$/

  @objects = []

  attr_reader :name, :trains
  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def self.all
    @objects
  end

  def initialize(name)
    @name = name
    @trains = []
    self.validate!
    self.class.all << self
  end

  def accept_trains(train)
    @trains << train
    "Поезд #{train.number} прибыл на станцию #{name}"
  end

  def send_train(train)
    @trains.delete(train)
    "Поезд #{train.number} отправился со станции #{name}"
  end

  def valid?
    self.validate!
  rescue StandardError
    false
  end

  def all_trains
    @trains.each do |train|
    end
  end

end
