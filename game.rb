# игровой интерфейс

class Game

  def greeting
    puts "Добро пожаловать в игру 'Black Jack'!"
    puts "Хотите сыграть: Yes / No ?"
    choice = gets.chomp
    case choice
    when "Yes"
      puts "Введите ваше имя: "
      name = gets.chomp
      user = User.new(name)
      dealer = Dealer.new
      bank = Bank.new
      sleep 2
      puts "#{user.name.capitalize!} с вами играет #{dealer.name}"
      puts dealer.inspect
      puts user.inspect
      sleep 2
      puts "Игра началась!"
      # метод для начала игры
    when "No"
      puts "Что ж! Всего хорошего! Ждем вас снова! :)"
    else
      puts "Что-то пошло не так..."
      greeting
    end
  end
end
