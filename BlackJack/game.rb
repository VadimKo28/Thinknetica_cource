class Game
  attr_accessor :status, :bank
  attr_reader :player1, :player2, :cards

  def initialize(player1, player2, cards)
    @bank = 0
    @cards = cards
    @player1 = player1
    @player2 = player2
    give_gards
    place_a_bet
  end

  def give_gards
    2.times do
      player1.cards << cards.shift
      player2.cards << cards.shift
    end
  end

  def place_a_bet
    player1.cash -= 10
    player2.cash -= 10
    self.bank += 20
  end
end