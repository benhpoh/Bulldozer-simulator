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
    return "No commands issued" if @commands.empty?
    @commands.join(", ")
  end

  def advance(distance=1)
    @facing == "East" ? @position_x += distance : nil
    @facing == "West" ? @position_x -= distance : nil
    @facing == "North" ? @position_y -= distance : nil
    @facing == "South" ? @position_y += distance : nil

    @commands << "Advance #{distance}"
  end
end