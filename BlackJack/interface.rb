class Interface
  attr_accessor :game_status, :game

  def initialize(user, dealer)
    @user = user
    @dealer = dealer
    @cards_deck = Cards.new.deck_of_cards
    @game = Game.new(user, dealer, cards_deck)
    @current_step = 'user'
    @game_status = 'start'
  end

  ACTIONS = {1 => "skip_action", 2 => "add_card", 3 => "open_cards" }

  def choose_player(choose_print)
    loop do
      break open_cards if dealer.cards.size == 3 && user.cards.size == 3

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

  def result_game
    dealer_points = dealer.total_points(dealer.cards)
    user_points = user.total_points(user.cards)

    puts "Ваши карты #{user.cards}"
    puts "Карты диллера#{dealer.cards}\n\n"

    win = if (user_points > 21) && (dealer_points > 21)
      game.bank -= 20
      user.cash += 10
      dealer.cash += 10
      "Никто не выйграл, у обоих перебор очков, у вас - #{user_points}, у диллера - #{dealer_points}. Ваш остаток #{user.cash}$"
    elsif  user_points == dealer_points
      game.bank -= 20
      user.cash += 10
      dealer.cash += 10
      "Ничья, у обоих по #{user_points} очков. Ваш остаток #{user.cash}$"
    elsif user_points > 21
      dealer.cash += game.bank
      game.bank -= 20
      "Перебор, вы проиграли - #{user_points} очков. Ваш остаток #{user.cash}$"
    elsif user_points > dealer_points
      user.cash += game.bank
      game.bank -= 20
      "Вы выйграли, у вас #{user_points} очков, у диллера #{dealer_points} очков. Ваш остаток #{user.cash}$"
    elsif dealer_points > 21
      user.cash += game.bank
      game.bank -= 20
      "Вы выйграли, у диллера перебор - #{dealer_points} очков. Ваш остаток #{user.cash}$"
    elsif dealer_points > user_points
      dealer.cash += game.bank
      game.bank -= 20
      "Вы проиграли, у диллера #{dealer_points} очков, у вас #{user_points} очков. Ваш остаток #{user.cash}$"
    end

    puts win
    puts
  end

  private
  attr_accessor :user, :dealer, :cards_deck, :current_step

  def user_step
    user_input = gets.to_i

    if user.cards.size == 3 && user_input == 2
      puts "Нельзя добавить больше 3х карт, выберите другое действие"
      self.current_step = 'dealer' #костыль, чтоб в цикле текущий ход сменился снова с диллера на юзера, смотреть 27ю строку
      return
    elsif ![1, 2, 3].include?(user_input)
      puts "Нет такого номера действия, попробуйте ещё раз"
      self.current_step = 'dealer'
      return
    end

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
    return
  end

  def add_card
    case current_step
    when "user"
      user.cards << cards_deck.shift
      puts "Вы добавили карту!"
    when "dealer"
      dealer.cards << cards_deck.shift
      puts "Диллер добавил карту!"
    end
  end

  def open_cards
    self.game_status = 'stop'
  end
end
