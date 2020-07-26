class Map
  
  def initialize(map_array)
    @map_array = map_array
    @path_travelled = []
  end
  
  def clear(x, y)
    x, y = convert_grid_to_index(x, y)
    if can_be_cleared?(x, y)
      @path_travelled << @map_array[y][x]
      @map_array[y][x] = "-"
      @path_travelled.last
      # Returns category of square that was cleared
    else
      @map_array[y][x] == "T" ? "T" : "OUT"
      # Returns category of illegal square being cleared
    end
  end

  def can_be_cleared?(x, y)
    if is_outside_site?(x, y) || is_protected_tree?(x, y)
      false
    else
      true
    end
  end

  def is_protected_tree?(x, y)
    @map_array[y][x] == "T" ? true : false
  end

  def is_outside_site?(x,y)
    if x < 0 || x >= @map_array[0].length
      true
    elsif y < 0 || y >= @map_array.length
      true
    else
      false
    end
  end

  def convert_grid_to_index(x, y)
    # programming index starts at 0, 0
    # map positioning starts at 1, 1
    [x-1, y-1]
  end

  def display
    @map_array.map { |row| row.join(" ") }
  end
end