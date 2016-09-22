class Battleships

  attr_reader :player1, :player2, :current_player

  def initialize(player1 = Player.new, player2 = Player.new)
    @player1 = player1
    @player2 = player2
    @current_player = @player1
  end

  def game_over?
    @player1.board.finished? || @player2.board.finished?
  end

  def switch_players
    @current_player = current_player == player1 ? @player2 : @player1
  end

  def opponent
    [player1, player2].select{|p| p != current_player}[0]
  end

  def winner
    return nil unless game_over?
    player1.board.finished? ? player2 : player1
  end

end
