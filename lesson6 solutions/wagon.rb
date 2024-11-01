class Wagon
  include ManufacturedCompany

  def initialize
    self.class.all << self
  end
end
