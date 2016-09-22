class Ship

  def initialize(x, y)
    @position = [x, y]
    @alive = true
  end

  def alive?
    @alive
  end

  def position
    @position.dup
  end

  def drown
    @alive = false
  end

end
