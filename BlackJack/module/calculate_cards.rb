module CalculateCards
  def total_points(cards)
    @cards = cards
    @points = calculate_points
  end

  # Здесь нет туза, его значение высчитываю ниже, в CARDS_POINTS_MAP.fetch(card[0], ace_value)
  CARDS_POINTS_MAP = {
    "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
    "8" => 8, "9" => 9, "1" => 10, "К" => 10, "Д" => 10, "В" => 10
  }

  private_constant :CARDS_POINTS_MAP

  private
  attr_accessor :cards, :points

  def calculate_points
    sum = 0

    cards.each do |card|
      sum += CARDS_POINTS_MAP.fetch(card[0], ace_value)
    end
    
    sum
  end

  def ace_value
    return 11 if points.nil?

    if points <= 10
      11
    else
      1
    end
  end
end
