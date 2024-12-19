class Interface
  attr_accessor :game_status

  def initialize
    @user = User.new
    @dealer = Dealer.new
    @cards_deck = Cards.new.deck_of_cards
    @game = Game.new(user, dealer, cards_deck)
    @current_step = 'user'
    @game_status = 'start'
  end

  ACTIONS = {1 => "skip_action", 2 => "add_card", 3 => "open_cards" }

  def choose_player(choose_print)
    loop do
      break open_cards if dealer.cards.size == 3 && dealer.cards.size == 3

      if current_step == 'user'
        puts choose_print
        user_step
        return if game_status == 'stop'
      else
        dealer_step
      end

      self.current_step = current_step == 'user' ? 'dealer' : 'user'

    end
  end

  def print_result_game
    dealer_points = dealer.total_points(dealer.cards)
    user_points = user.total_points(user.cards)

    win = if user_points == dealer_points
      "Ничья, у обоих по #{user_points} очков"
    elsif (user_points > 21) && (dealer_points > 21)
      "Никто не выйграл, у обоих перебор очков, у вас - #{user_points}, у диллера - #{dealer_points}"
    elsif user_points > 21
      "Перебор, вы проиграли - #{user_points}"
    elsif user_points > dealer_points
      "Вы выйграли, у вас #{user_points} очков, у диллера #{dealer_points} очков"
    elsif dealer_points > 21
      "Вы выйграли, у диллера перебор - #{dealer_points}"
    elsif dealer_points > user_points
      "Вы проиграли, у диллера #{dealer_points} очков, у вас #{user_points} очков"
    end

    puts win
    puts
  end

  private
  attr_accessor :user, :dealer, :cards_deck, :game, :current_step

  def user_step
    user_input = gets.to_i

    eval(ACTIONS[user_input])
  end

  def dealer_step
    deler_cards_points = dealer.total_points(dealer.cards)

    if deler_cards_points >= 17
      skip_action
    else
      add_card
    end
  end

  def skip_action
    msg = case current_step
    when "user"
      "Вы пропускаете ход!!!!!!!!!!!!!!"
    when "dealer"
      "Диллер пропускает ход!!!!!!!!!!!!"
    end

    puts msg
    return :next
  end

  def add_card
    return puts "Нельзя добавить больше 3х карт" if user.cards.size == 3 || dealer.cards.size == 3

    case current_step
    when "user"
      user.cards << cards_deck.shift
      user.total_points(user.cards)
      puts "Вы добавили карту!"
    when "dealer"
      dealer.cards << cards_deck.shift
      dealer.total_points(dealer.cards)
      puts "Диллер добавил карту!"
    end
  end

  def open_cards
    puts "Карты диллера #{dealer.cards}"
    puts "Ваши карты #{user.cards}"
    self.game_status = 'stop'
  end

end
