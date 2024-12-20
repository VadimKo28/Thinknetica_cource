require_relative 'module/calculate_cards.rb'
require_relative 'dealer.rb'
require_relative 'user.rb'
require_relative 'cards.rb'
require_relative 'game.rb'
require_relative 'interface.rb'
require 'byebug'

choose_print = <<~MSG
  Следующий ход за вами, для этого выберите номер дальнейшего действия
  1. Пропустить ход
  2. Добавить карту(может быть добавлена только одна)
  3. Открыть карты
MSG

user = User.new
dealer = Dealer.new

loop do
  interface = Interface.new(user, dealer)

  game = interface.game

  game.give_gards

  game.place_a_bet

  start_msg = <<~MSG
    Старт Игры!!!!
    Вы сделали ставку 10$, ваш баланс #{user.cash}$"
    Ваши карты #{user.cards}\n
  MSG

  puts start_msg

  interface.choose_player(choose_print)

  interface.result_game if interface.game_status == 'stop'

  puts "Хотите ещё раз сыграть?\n1 - Да\n2 - Нет"

  user_input_return_game = gets.to_i

  break puts "Конец игры, у вас закончились деньги" if user.cash == 0

  if user_input_return_game == 1
    game.reset_cards
    next
  elsif user_input_return_game == 2
    break puts "Вы вышли"
  else
    break puts "Такого варианта нет"
  end
end