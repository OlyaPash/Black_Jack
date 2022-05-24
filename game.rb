# игровой интерфейс

class Game
  attr_reader :user, :dealer, :card_deck, :bank

  def initialize
    # user = User.new(name)
    @dealer = Dealer.new
    @bank = Bank.new
    @card_deck = CardDeck.new
  end

  def greeting
    puts "Добро пожаловать в игру 'Black Jack'!"
    puts "Ставка: #{@bank.bet}$"
    puts "Хотите сыграть: 1 - Да, 2 - Нет ?"
    choice = gets.to_i
    case choice
    when 1
      puts "Введите ваше имя: "
      name = gets.chomp
      @user = User.new(name)
      sleep 2
      puts "#{@user.name} с вами играет #{@dealer.name}"
      puts "У вас на балансе: #{user.balance}$"
      sleep 2
      puts "Игра началась!"
      round
    when 2
      puts "Что ж! Всего хорошего! Ждем вас снова! :)"
    else
      puts "Что-то пошло не так..."
      greeting
    end
  end

  def round
    puts "Началась раздача"
    @user.new_round
    @dealer.new_round
    2.times {user.add_cards(card_deck)}
    puts "Вы получили карты : #{user.cards_on_hand}"
    2.times {@dealer.add_cards(card_deck)}
    puts "Карты #{dealer.name}а: #{@dealer.close_cards}"
    @bank.take(user)
    @bank.take(dealer)
    puts "Ставки сделаны!"
    puts "Банк игроков на начало игры: #{bank.balance_bank}$"
    puts "Ваши очки: #{card_deck.count_points(user.cards_on_hand)}"
    user_choice
  end

  def user_choice
    @user.open_cards && winner if @dealer.cards_on_hand.count == 3 && @user.cards_on_hand.count == 3
    puts "Ваш ход, #{user.name}"
    puts "1 - Пропустить"
    puts "2 - Добавить карту"
    puts "3 - Открыть карты"
    puts "0 - Закончить игру"
    input
  end

  def input
    choice = gets.to_i
    case choice
    when 1
      puts "Ход переходит #{dealer.name}y"
      dealer_choice
    when 2
      # только если у пользователя на руках 2 карты
      if @user.cards_on_hand.count == 2
        @user.add_cards(card_deck)
        puts "Ваши карты: #{user.cards_on_hand}"
        puts "Сумма ваших очков: #{card_deck.count_points(user.cards_on_hand)}"
        # @user.open_cards && winner if @dealer.cards_on_hand.count == 3
        dealer_choice
      else
        puts "Вы можете взять карту только если на руках 2 карты"
        user_choice
      end
    when 3
      open
    when 0
      puts "До свидания!"
    end  
  end

  def open
    puts "Открываем карты"
    puts "Ваши карты: #{user.open_cards}, ваши очки: #{card_deck.count_points(user.cards_on_hand)}"
    puts "Карты оппонента: #{dealer.open_cards}, очки: #{card_deck.count_points(dealer.cards_on_hand)}"
    winner
  end

  def dealer_choice
    open if @user.cards_on_hand.count == 3 && @dealer.cards_on_hand.count == 3
    # пропустить
    if card_deck.count_points(dealer.cards_on_hand) >= 17
      puts "#{dealer.name} пропускает ход."
      user_choice
    # добавить карту
    elsif card_deck.count_points(dealer.cards_on_hand) < 17
      dealer.add_cards(card_deck)
      puts "#{dealer.name} взял карту: #{@dealer.close_cards}"
      user_choice
    else
      puts "#{@dealer.name} не взял карту"
    end
    # открыть
  end

  def winner
    @user_points = @card_deck.count_points(user.cards_on_hand)
    @dealer_points = @card_deck.count_points(dealer.cards_on_hand)

    if @user_points > @dealer_points && @user_points <= 21 || @user_points <= 21 && @dealer_points > 21
      puts "Поздравляем! Вы выиграли раздачу, сумма в вашем банке #{@user.balance += @bank.balance_bank}$"
      puts "Банк #{dealer.name}а: #{@dealer.balance}$"
      @bank.balance_bank = 0
    elsif @user_points < @dealer_points || @user_points > 21
      puts "К сожалению вы проиграли раздачу. Ваш банк: #{@user.balance}$"
      puts "Банк #{dealer.name}a: #{@dealer.balance += @bank.balance_bank}$"
      @bank.balance_bank = 0
    else
      @user_points == @dealer_points
      @bank.give(user)
      @bank.give(dealer)
      puts "Ничья! Ваш банк: #{@user.balance}$, банк #{dealer.name}a #{@dealer.balance}$"
      @bank.balance_bank = 0
    end

    round if @user.balance != 0 || @dealer.balance != 0
    restart if @user.balance.zero? || @dealer.balance.zero?
  end

  def restart
    puts "Хотите сыграть ещё раз? 1 - да, 2 - нет"
    input = gets.to_i
    greeting if input == 1
    exit if input == 2
  end

  # - Выигрывает игрок, у которого сумма очков ближе к 21
  # - Если у игрока сумма очков больше 21, то он проиграл
  # - Если сумма очков у игрока и дилера одинаковая,
  # то объявляется ничья и деньги из банка возвращаются игрокам
  # - Сумма из банка игры переходит к выигравшему

end
