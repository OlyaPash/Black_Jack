# Подсчет результатов:
# - Выигрывает игрок, у которого сумма очков ближе к 21
# - Если у игрока сумма очков больше 21, то он проиграл
# - Если сумма очков у игрока и дилера одинаковая,
# то объявляется ничья и деньги из банка возвращаются игрокам
# - Сумма из банка игры переходит к выигравшему

class Bank
  attr_accessor :balance_bank, :bet
  attr_reader :player

  def initialize
    @balance_bank = 0
    @bet = 10
  end

  def give(player)
    player.balance += @bet
    self.balance_bank -= @bet
  end

  def take(player)
    player.balance -= @bet
    self.balance_bank += @bet
  end

  # метод для подсчета очков
  def count_points; end
end

