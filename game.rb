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
    puts "Хотите сыграть: Yes / No ?"
    choice = gets.chomp
    case choice
    when "Yes"
      puts "Введите ваше имя: "
      name = gets.chomp
      @user = User.new(name)
      sleep 2
      puts "#{user.name.capitalize!} с вами играет #{dealer.name}"
      puts "У вас на балансе: #{user.balance}$"
      sleep 2
      puts "Игра началась!"
      round
    when "No"
      puts "Что ж! Всего хорошего! Ждем вас снова! :)"
    else
      puts "Что-то пошло не так..."
      greeting
    end
  end

  def round
    2.times {user.add_cards(card_deck)}
    puts "Вы получили карты : #{user.cards_on_hand}"
    2.times {@dealer.add_cards(card_deck)}
    puts "Карты Дилера: #{@dealer.close_cards}"
    @bank.take(user)
    @bank.take(dealer)
    puts "Ставки сделаны!"
    puts "Банк игроков на начало игры: #{bank.balance_bank}$"
    puts dealer.inspect
    puts user.inspect
    puts bank.inspect
    puts "Ваши очки: #{card_deck.count_points(user.cards_on_hand)}"
    user_choice
  end

  def user_choice
    puts "Ваш ход, #{user.name}"
    puts "1 - Пропустить"
    puts "2 - Добавить карту"
    puts "3 - Открыть карты"
    input
  end

  def input
    choice = gets.to_i
    case choice
    when 1
      puts "Ход переходит #{dealer.name}"
      dealer_choice
    when 2
      # только если у пользователя на руках 2 карты
      if @user.cards_on_hand.count == 2
        @user.add_cards(card_deck)
        puts "Ваши карты: #{user.cards_on_hand}"
        puts "Сумма ваших очков: #{card_deck.count_points(user.cards_on_hand)}"
        open_cards if @dealer.cards_on_hand.count == 3
        dealer_choice
      else
        puts "Вы можете взять карту только если на руках 2 карты"
        user_choice
      end
    when 3
      puts "Открываем карты"
      puts "Ваши карты: #{user.open_cards}, Ваши очки: #{card_deck.count_points(user.cards_on_hand)}"
      puts "Карты оппонента: #{dealer.open_cards}, очки: #{card_deck.count_points(user.cards_on_hand)}"
    end  
  end

  def dealer_choice
    # пропустить
    if card_deck.count_points(dealer.cards_on_hand)} >= 17
      puts "#{dealer.name} пропускает ход."
      user_choice
    # добавить карту
    elsif card_deck.count_points(dealer.cards_on_hand)} < 17
      dealer.add_cards(card_deck)
      puts "#{dealer.name} взял карту: #{@dealer.close_cards}"
      open_cards if @user.cards_on_hand.count == 3
      user_choice
    else
      puts "#{@dealer.name} не взял карту"
    end
    # открыть
  end

end
