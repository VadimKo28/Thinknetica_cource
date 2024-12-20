class Game
  attr_accessor :status, :bank
  attr_reader :user, :dealer, :cards

  def initialize(user, dealer, cards)
    @bank = 0
    @cards = cards
    @user = user
    @dealer = dealer
  end

  def give_gards
    2.times do
      user.cards << cards.shift
      dealer.cards << cards.shift
    end
  end

  def reset_cards
    user.cards = []
    dealer.cards = []
  end

  def place_a_bet
    user.cash -= 10
    dealer.cash -= 10
    self.bank += 20
  end
end