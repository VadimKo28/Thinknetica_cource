class Station 
  attr_reader :trains_in_station, :name
  def initialize(name)
    @name = name
    @trains_in_station = []
  end

  def accept_trains(train)
    @trains_in_station << train
    puts "Поезд #{train} прибыл на станцию #{name}"

  end

  def send_train(train)
    @trains_in_station.delete(train)
    puts "Поезд #{train} отправился со станции #{name}"
  end
end