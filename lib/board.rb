class Board

  MAX_NUM_OF_SHIPS = 3

  attr_reader :max_ships

  def initialize(max_ships = MAX_NUM_OF_SHIPS)
    @max_ships = max_ships
    @ships = []
  end

  def ships
    @ships.dup
  end

  def full?
    ships.length >= max_ships
  end

  def finished?
    ships.each do |ship|
      return false if ship.alive?
    end
    true
  end

  def place_ship(position)
    check_placement_position(position)
    @ships << Ship.new(position[0], position[1]) unless full?
  end

  private

  def check_placement_position(position)
    if position[0] > 10 || position[1] > 10 || position[0] < 1 || position[1] < 1
      raise "Ship must be placed within the board's boundaries."
    end
    if ships.map{|ship| ship.position}.include? position
      raise "Another ship is already at this position."
    end
  end

end
