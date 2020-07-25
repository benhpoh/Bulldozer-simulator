class Bulldozer
  def initialize()
      @position_x = 0
      @position_y = 1
      @facing = "East"
      @commands = []
  end

  # instance method
  def location()
      "X - #{@position_x}; Y - #{@position_y}; Facing - #{@facing}"
  end

  def left()
    direction = ["East", "North", "West", "South"]
    @facing = direction[direction.index(@facing) + 1] || "East"
  end

  def right()
    direction = ["East", "North", "West", "South"]
    @facing = direction[direction.index(@facing) - 1]
  end
end