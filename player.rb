# родительский класс Игрок
# 2 игрока: пользователь и дилер(программа)

class Player
  attr_accessor :balance, :get_cards, :name
  attr_reader :card_deck

  def initialize(*_args)
    @name = name
    @balance = 100 # банк игрока
    # @get_cards = []
  end

  # def make_bet(bet)
  #   @balance -= bet
  # end

  # def get_money(money)
  #   @balance += money
  # end

  def scoring
    @score = 0
  end

  # добавить\взять карту. Добавляется 1 случайная карта. Ход переходит
  def take_a_card(card_deck)
    # только если у пользователя на руках 2 карты
    # дилеру: если очков менее 17
    get_cards = card_deck.give_random_card
  end

  # пропустить ход
  def skip
    # для игрока: ход переходит дилеру
    # для дилера: если очков у дилера 17 или более. Ход переходит игроку
  end

  def open_cards; end
end
