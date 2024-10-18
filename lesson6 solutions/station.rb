class Station 
  #название станции может иметь только русские буквы не менее 3х символов 
  NAME_FORMAT = /^([А-Яа-яЁё]{3,})$/

  @objects = []

  include InstanceCounter

  attr_reader :name, :trains

  def self.all 
    @objects
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self 
    validate!
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
    validate!
  rescue
    false
  end

  private 

  def validate!
    raise "Name has invalid format" if name !~ NAME_FORMAT
    true
  end

end
