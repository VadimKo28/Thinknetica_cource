require_relative 'module/calculate_cards.rb'
require_relative 'dealer.rb'
require_relative 'user.rb'
require_relative 'cards.rb'
require_relative 'game.rb'
require_relative 'interface.rb'
require 'byebug'

choose_print = <<~MSG
  Ваш ход, для этого выберите номер дальнейшего действия
  1. Пропустить ход
  2. Добавить карту(может быть добавлена только одна)
  3. Открыть карты
MSG

loop do
  interface = Interface.new

  interface.choose_player(choose_print)

  interface.print_result_game if interface.game_status == 'stop'

  puts "Хотите ещё раз сыграть?\n1 - Да\n2 - Нет"

  user_input_return_game = gets.to_i

  break puts "Вы вышли" if user_input_return_game == 2

  next if user_input_return_game == 1
end