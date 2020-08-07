require_relative "land_type"

class Map
  attr_reader :map_array, :routes

  def initialize(map_array)
    @map_array = convert_txt_map(map_array)
    @routes = []
  end
  
  def clear(x, y)
    x, y = convert_grid_to_index(x, y)
    if can_be_cleared?(x, y)
      square_cleared = @map_array[y][x]
      @map_array[y][x] = Land.new("cleared")

      square_cleared
      # Returns type of square that was cleared

    else # Attempted to clear illegal square
      return Land.new("out") if @map_array[y].nil? || @map_array[y][x].nil?

      @map_array[y][x]
      # Returns type of illegal square being cleared
    end
  end

  def can_be_cleared?(x, y)
    within_site?(x, y) && @map_array[y][x].clearable?
  end

  def within_site?(x,y)
    x >= 0 &&
    x < @map_array[0].length &&
    y >= 0 &&
    y < @map_array.length
  end

  def convert_grid_to_index(x, y)
    # programming index starts at 0, 0
    # map positioning starts at 1, 1
    [x-1, y-1]
  end

  def display
    @map_array.map do |row|
      row.map { |land| land.symbol }
        .join(" ")
    end
  end

  def log_route(route_section)
    @routes << route_section
  end

  def convert_txt_map(string_2d_array)
    string_2d_array.each do |string_array|
      string_array.map! {|char| Land.new(char) }
    end
  end
end