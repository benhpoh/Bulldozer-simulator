class Position
  def initialize
    @position_x = 0
    @position_y = 1
    @facing = :East
  end

  def rotate_left
    direction = [:South, :West, :North, :East]
    @facing = direction[direction.index(@facing) - 1]
  end

  def rotate_right
    direction = [:East, :North, :West, :South]
    @facing = direction[direction.index(@facing) - 1]
  end

  def advance
    @facing == :East ? @position_x += 1 : nil
    @facing == :West ? @position_x -= 1 : nil
    @facing == :North ? @position_y -= 1 : nil
    @facing == :South ? @position_y += 1 : nil
  end

  def x
    @position_x
  end

  def y
    @position_y
  end

  def facing
    @facing
  end
end