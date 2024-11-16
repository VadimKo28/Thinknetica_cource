class CargoTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_TRAIN_FORMAT


  @objects = []

  def add_wagon(wagon)
    return puts 'Пассажирский вагон не пристыковать к грузовому поезду' unless wagon.type == 'cargo'

    super
  end
end
