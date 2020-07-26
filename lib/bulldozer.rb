class Bulldozer
  def initialize()
      @position_x = 0
      @position_y = 1
      @facing = "East"
      @commands = []
  end

  def execute(command)
    command = command.split(" ")

    case command[0]
      when "l"
        left()
      when "r"
        right()
      when "a"
        command[1].nil? ? advance(1) : advance(command[1])
      when "lo"
        puts location()
      else
        return false
    end
  end

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
    distance = distance.to_i

    distance.times do
      @facing == "East" ? @position_x += 1 : nil
      @facing == "West" ? @position_x -= 1 : nil
      @facing == "North" ? @position_y -= 1 : nil
      @facing == "South" ? @position_y += 1 : nil
    end
    
    @commands << "Advance #{distance}"
  end
end