class PassengerTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_TRAIN_FORMAT

  @objects = []

  def add_wagon(wagon)
    return 'Грузовой вагон не пристыковать к пассажирскому поезду' unless wagon.type == 'passenger'

    super
  end
end
