require_relative 'player'
# дилер

class Dealer < Player
  attr_reader :name

  def initialize
    super
    @name = "Dealer"
  end

  # def add_cards(card_deck)
  #   # дилеру: если очков менее 17
  #   card_deck.count_points(cards_on_hand)
  #   if points < 17
  #     super
  #   else
  #     puts "#{@name} не взял карту"
  #   end
  # end

  def close_cards
    @cards_on_hand.map { |card| card = '*' }
  end

end

# card_deck = CardDeck.new

# dealer = Dealer.new
# 2.times {dealer.add_cards(card_deck)}
# puts dealer.inspect
