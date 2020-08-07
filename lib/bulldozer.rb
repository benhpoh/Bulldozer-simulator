require_relative "map"

class Bulldozer

  def initialize(map_array)
    @position_x = 0
    @position_y = 1
    @facing = :East
    @map = Map.new(map_array)
  end

  def location()
    "X - #{@position_x}; Y - #{@position_y}; Facing - #{@facing}"
  end

  def map()
    new_line = "\n"
    puts [
      new_line,
      @map.display,
      new_line,
      "Bulldozer's current location:",
      new_line,
      location(),
      new_line
    ]
  end

  def left()
    direction = [:South, :West, :North, :East]
    @facing = direction[direction.index(@facing) - 1]
  end
  
  def right()
    direction = [:East, :North, :West, :South]
    @facing = direction[direction.index(@facing) - 1]
  end

  def advance(distance)
    path_travelled = []
    distance = distance.to_i

    distance.times do
      @facing == :East ? @position_x += 1 : nil
      @facing == :West ? @position_x -= 1 : nil
      @facing == :North ? @position_y -= 1 : nil
      @facing == :South ? @position_y += 1 : nil

      square_cleared = @map.clear(@position_x, @position_y)

      if square_cleared.clearable?
        path_travelled << square_cleared
      else
        @map.log_route(path_travelled)
        return {advance_successful: false, error_code: square_cleared.symbol}
      end

    end

    @map.log_route(path_travelled)
    {advance_successful: true}
  end

  def shutdown
    {routes: @map.routes, end_map: @map.map_array}
  end
end
