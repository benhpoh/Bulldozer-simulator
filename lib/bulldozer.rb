require_relative "map"
require_relative "cost"

class Bulldozer
  attr_reader :commands, :routes

  def initialize(map_array)
    @position_x = 0
    @position_y = 1
    @facing = "East"
    @commands = []
    @map = Map.new(map_array)
    @routes = []
  end

  def execute(command)
    ###### once again can you abstract that further??
    ## what's command[0] and command[1]?? just name some variables
    command = command.split(" ")

    #### you could name better left() and right(). what is it? turn_left? handle_left? is_left?
    case command[0]
      when "l"
        left()
      when "r"
        right()
      when "a"
        ## this is barely passing....
        command[1].nil? ? advance(1) : advance(command[1])
      when "m"
        ### can you abstract line 33-38 to a function named:
        # print_map()
        puts "\n"
        puts map()
        puts "\nBulldozer's current location:"
        puts location()
        puts "\n"
        [true, "Reference only"]
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
    @map.display
  end

  def left()
    @commands << "Turn left"
    direction = ["South", "West", "North", "East"]
    @facing = direction[direction.index(@facing) - 1]
  end
  
  def right()
    @commands << "Turn right"
    direction = ["East", "North", "West", "South"]
    @facing = direction[direction.index(@facing) - 1]
  end

  def history()
    return "No commands issued" if @commands.empty?  ######## I like this, mofo

    @commands.join(", ")
  end
  ##### I swapped cost and advance around, advance is more low level hence should be lower
  def cost()
    cost = Cost.new(@commands, @routes, @map.map_array)
    cost.calculate_total
  end

  def advance(distance=1)
    path_travelled = []
    distance = distance.to_i

    distance.times do
      @facing == "East" ? @position_x += 1 : nil
      @facing == "West" ? @position_x -= 1 : nil
      @facing == "North" ? @position_y -= 1 : nil
      @facing == "South" ? @position_y += 1 : nil

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
end
