DECK = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
VALUE = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11]
WIN = 21

def propmt(message)
  puts "=> #{message}"
end

def add_some_space
  propmt "+ - + - + - + - +"
end

def draw_card_user(user)
  random = DECK.sample
  x = DECK.find_index(random)
  USER_TOTAL << VALUE[x]
  user = "#{random}"
end

def draw_card_comp(user)
  random = DECK.sample
  x = DECK.find_index(random)
  y = COMP_TOTAL << VALUE[x]
  user = "#{random}"
end

def initial_draw_user(user)
  card1 = draw_card_user(user)
  card2 = draw_card_user(user)
  propmt "#{user}: #{card1}, #{card2}"
end

def initial_draw_comp(user)
  card1 = draw_card_comp(user)
  card2 = draw_card_comp(user)
  propmt "#{user}: #{card1}, -"
end

def show_cards(players_total)
  total = 0
  players_total.each { |x| total += x}
  propmt "Total: #{total}"
end

def comp_draw(user)
  total = COMP_TOTAL.reduce(:+)
  if total <= 17
    draw_card_comp(user)
  end
end

def hit_stay(user, comp)
  loop do
  propmt "Would you like to:"
  propmt "1) HIT 2) STAY"
  player_move = gets.downcase.chomp

  if player_move == '1'
    propmt("New card: #{draw_card_user(user)}")
    x = USER_TOTAL.reduce(:+)
    if x > 12
      VALUE[12] = 1
    else
      VALUE[12] = 11
    end
    propmt "Total: #{x}"
  elsif player_move == '2'
    propmt "You chose to stay"
    break
  end
end
end

def winner?(player, score, comp, comp_score)
  comp_draw(comp)
  comp = comp_score.reduce(:+)
  user = score.reduce(:+)
  show_final_score(user, comp)
  case
    when user == WIN && comp == WIN
      propmt "Its a tie at 21!"
    when user == comp
      propmt "its a TIE"
    when user == WIN
      propmt "+ - Player WINS! 21 - +"
      return "player"
    when comp == WIN
      propmt "+ - Comp wins! 21 - +"
      return 'comp'
    when user > WIN && comp > WIN
      propmt "Double BUSTer!"
    when user > WIN && comp < WIN
      propmt "Comp wins!"
      return 'comp'
    when user < WIN && comp > WIN
      propmt "Player WINS!"
      return "player"
    when user > comp && user < WIN
      propmt "Player WINS!"
      return "player"
    when user < comp && comp < WIN
      propmt "Comp wins!"
      return 'comp'
  end
end

def show_final_score(user, comp)
  propmt "FINAL Player: #{user}, Comp: #{comp}"
end

loop do
user_score = 0
comp_score = 0
  loop do
    USER_TOTAL = []
    COMP_TOTAL = []

    system 'clear'

    propmt " Welcome to 21!"
    add_some_space
    propmt "Player total: #{user_score}"
    propmt "Comp total: #{comp_score}"
    add_some_space
    propmt "* * * DRAW * * *"
    player1 = 'Player1'
    comp = 'Computer'

    initial_draw_comp(comp)
    initial_draw_user(player1)
    show_cards(USER_TOTAL)

    add_some_space

    hit_stay(USER_TOTAL, COMP_TOTAL)

    x = winner?(player1, USER_TOTAL, comp, COMP_TOTAL)

    if x == 'player'
      user_score += 1
    elsif x == 'comp'
      comp_score += 1
    end

    sleep(2)

    if user_score == 5
      propmt "PLAYER WINS!!!!!"
      sleep(1)
      break
    elsif comp_score == 5
      propmt "Comp wins, better luck next time"
      sleep(1)
      break
    end
  end

propmt "Press '1' to play again!"
cont = gets.to_i

break if cont != 1
end

propmt "Thanks for playing"
