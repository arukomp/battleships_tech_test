require_relative 'battleships'
require_relative 'board'
require_relative 'player'
require_relative 'ship'
require_relative 'shot'

class BattleshipsApp

  WELCOME_MESSAGE = "Welcome to Battleships!"

  def initialize(game = Battleships.new)
    @game = game
  end

  def start
    puts WELCOME_MESSAGE
    game_loop
  end

  def game_loop
    loop do
      ship_placement_loop unless players_ready?
      break if game.game_over?
      if next_turn_result
        puts "HIT! You get to go again!"
      else
        puts "Miss... Better luck next turn."
        game.switch_players
      end
    end
    puts "-- GAME OVER! --"
    puts "-- The winner is... " + get_player_name(game.winner) + "!"
    puts "Thank you for playing"
  end

  def ship_placement_loop
    loop do
      break if players_ready?
      game.switch_players if game.current_player.ready?
      position = get_position_from_user
      begin
        game.current_player.board.place_ship(position)
      rescue => error
        puts error
      end
    end
  end

  private

  attr_reader :game

  def players_ready?
    game.player1.ready? && game.player2.ready?
  end

  def get_player_name(player)
    player == game.player1 ? "Player 1" : "Player 2"
  end

  def get_position_from_user
    print "#{get_player_name(game.current_player)}, please enter your ship placement position (x y): "
    take_and_parse_position_input
  end

  def next_turn_result
    puts "Your previous shots: #{ format_shot_history(game.current_player.history) }"
    print "#{get_player_name(game.current_player)}'s turn. Enter the your target shot position: "
    position = take_and_parse_position_input
    begin
      game.current_player.shoot(game.opponent, position)
    rescue => error
      puts error
      next_turn_result
    end
  end

  def take_and_parse_position_input
    gets.chomp.split(' ').map(&:to_i)
  end

  def format_shot_history(history)
    history.map do |shot|
      {
        position: shot.position,
        result: shot.miss? ? 'miss' : 'HIT'
      }
    end
  end

end
