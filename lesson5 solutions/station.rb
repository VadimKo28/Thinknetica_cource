class Station 
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
  end

  def accept_trains(train)
    @trains << train
    puts "Поезд #{train.number} прибыл на станцию #{name}"
  end

  def send_train(train)
    @trains.delete(train)
    puts "Поезд #{train.number} отправился со станции #{name}"
  end

end
