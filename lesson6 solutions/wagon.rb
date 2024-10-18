class Wagon
  include ManufacturedCompany

  attr_reader :type

  def initialize
    @type = type
    self.class.all << self 
  end
end