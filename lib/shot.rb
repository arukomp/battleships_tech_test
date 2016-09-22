class Shot

  def initialize(board, target_position)
    @board = board
    @target_position = target_position
    @miss = true
    process_the_shot
  end

  def miss?
    @miss
  end

  def process_the_shot
    @board.ships.each do |ship|
      if ship.position == @target_position
        @miss = false
        ship.drown
      end
    end
  end

  def position
    @target_position.dup
  end

end
