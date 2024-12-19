class Dealer
  include CalculateCards

  attr_accessor :cash, :cards

  def initialize
    @cash = 100
    @cards = []
  end

end