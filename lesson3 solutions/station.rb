class Station 
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def accept_trains(train)
    @trains << train
    puts "Поезд #{train} прибыл на станцию #{name}"

  end

  def send_train(train)
    @trains.delete(train)
    puts "Поезд #{train} отправился со станции #{name}"
  end
end
