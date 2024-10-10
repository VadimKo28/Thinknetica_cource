class PassengerTrain < Train
  @objects = []

  def add_wagon(wagon)
    return puts "Грузовой вагон не пристыковать к пассажирскому поезду" unless wagon.type == 'passenger' 
    super
  end
end