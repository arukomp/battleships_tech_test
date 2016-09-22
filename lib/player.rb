class Player

  attr_reader :board

  def initialize(board = Board.new)
    @board = board
    @history = []
  end

  def history
    @history.dup
  end

  def ready?
    @board.full?
  end

  def shoot(player, target_position)
    check_target_position(target_position)
    shot = Shot.new(player.board, target_position)
    @history << shot
    !shot.miss?
  end

  private

  def check_target_position(position)
    if position[0] > 10 || position[0] < 1 || position[1] > 10 || position[1] < 1
      raise "Cannot shoot outside the boundaries."
    end
  end

end
