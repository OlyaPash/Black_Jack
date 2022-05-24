require_relative 'player'
# дилер

class Dealer < Player
  attr_reader :name

  def initialize
    super
    @name = "Dealer"
  end

  def close_cards
    @cards_on_hand.map { |card| card = '*' }
  end
end
