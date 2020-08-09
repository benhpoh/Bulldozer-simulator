require_relative "map"
require_relative "position"

class Bulldozer

  def initialize(map_array)
    @position = Position.new
    @map = Map.new(map_array)
  end

  def location()
    "X - #{@position.x}; Y - #{@position.y}; Facing - #{@position.facing}"
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
    @position.rotate_left
  end
  
  def right()
    @position.rotate_right
  end

  def advance(distance)
    path_travelled = []
    distance = distance.to_i

    distance.times do
      @position.advance

      square_cleared = @map.clear(@position.x, @position.y)

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
