class Station 
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
