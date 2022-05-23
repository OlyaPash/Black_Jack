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
      puts dealer.inspect
      puts user.inspect
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
    @bank.take(user)
    @bank.take(dealer)
    puts "Ставки сделаны!"
    puts "Вы получили карты : #{@user.take_a_card(card_deck)}"
  end
end
