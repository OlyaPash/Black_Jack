# колода карт

class CardDeck
  attr_accessor :points
  attr_reader :card_deck, :cards, :deck_hash, :deck_arr

  # массив карт
  def initialize
    @deck_hash = {
      '2♣': 2, '3♣': 3, '4♣': 4, '5♣': 5, '6♣': 6, '7♣': 7, '8♣': 8,
      '9♣': 9, '10♣': 10, J♣: 10, Q♣: 10, K♣: 10, A♣: 11,
      '2♥': 2, '3♥': 3, '4♥': 4, '5♥': 5, '6♥': 6, '7♥': 7, '8♥': 8,
      '9♥': 9, '10♥': 10, J♥: 10, Q♥: 10, K♥: 10, A♥: 11,
      '2♠': 2, '3♠': 3, '4♠': 4, '5♠': 5, '6♠': 6, '7♠': 7, '8♠': 8,
      '9♠': 9, '10♠': 10, J♠: 10, Q♠: 10, K♠: 10, A♠: 11,
      '2♦': 2, '3♦': 3, '4♦': 4, '5♦': 5, '6♦': 6, '7♦': 7, '8♦': 8,
      '9♦': 9, '10♦': 10, J♦: 10, Q♦: 10, K♦: 10, A♦: 11
    }
  end

  def give_random_card
    @deck_arr = []
    @deck_hash.each { |cards, _volue| @deck_arr << cards }
    card = @deck_arr.sample
    @deck_arr.delete(card)
    card
  end

  # метод для подсчета очков
  def count_points(cards)
    @points = 0
    cards.each do |card|
      @points += @deck_hash[card.to_sym]
      @points -= 10 if points > 21 && cards.join('').include?('A')
    end
    @points
  end

  # Пользователь видит сумму своих очков.
  # Сумма считается так: от 2 до 10 - по номиналу карты,
  # все «картинки» - по 10,
  # туз - 1 или 11, в зависимости от того,
  # какое значение будет ближе к 21 и что не ведет к проигрышу (сумме более 21).
end
