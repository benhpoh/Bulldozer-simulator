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
    @commands << "Turn left"
    direction = ["East", "North", "West", "South"]
    @facing = direction[direction.index(@facing) + 1] || "East"
  end
  
  def right()
    @commands << "Turn right"
    direction = ["East", "North", "West", "South"]
    @facing = direction[direction.index(@facing) - 1]
  end

  def history()
    if @commands.empty?
      return "No commands issued" 
    end
    @commands.join(", ")
  end
end