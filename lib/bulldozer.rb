require_relative "map"
require_relative "cost"

class Bulldozer
  attr_reader :commands, :routes

  def initialize(map_array)
    @position_x = 0
    @position_y = 1
    @facing = :East
    @commands = []
    @map = Map.new(map_array)
    @routes = []
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
      when "m"
        map()
      when "q"
        [false, "QUIT"]
      else
        [false, "Invalid command"]
    end
  end

  def location()
    "X - #{@position_x}; Y - #{@position_y}; Facing - #{@facing}"
  end

  def map()
    puts "\n"
    puts @map.display
    puts "\nBulldozer's current location:"
    puts location()
    puts "\n"
    
    [true, "Reference only"]
  end

  def left()
    @commands << "Turn left"
    direction = [:South, :West, :North, :East]
    @facing = direction[direction.index(@facing) - 1]
  end
  
  def right()
    @commands << "Turn right"
    direction = [:East, :North, :West, :South]
    @facing = direction[direction.index(@facing) - 1]
  end

  def history()
    return "No commands issued" if @commands.empty?

    @commands.join(", ")
  end

  def advance(distance=1)
    path_travelled = []
    distance = distance.to_i

    distance.times do
      @facing == :East ? @position_x += 1 : nil
      @facing == :West ? @position_x -= 1 : nil
      @facing == :North ? @position_y -= 1 : nil
      @facing == :South ? @position_y += 1 : nil

      square_cleared = @map.clear(@position_x, @position_y)

      if square_cleared == "T"
        return [false, "T"]
      elsif square_cleared == "OUT"
        return [false, "OUT"]
      else
        path_travelled << square_cleared
      end
    end

    @routes << path_travelled

    @commands << "Advance #{distance}"
  end

  def cost()
    cost = Cost.new(@commands, @routes, @map.map_array)
    cost.calculate_total
  end
end
