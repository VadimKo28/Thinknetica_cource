class CargoTrain < Train
  @objects = []
   
  def add_wagon(wagon)
    return "Пассажирский вагон не пристыковать к грузовому поезду" unless wagon.type == 'cargo' 
    super
  end
end