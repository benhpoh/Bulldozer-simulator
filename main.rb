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
end