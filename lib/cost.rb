class Cost
  def initialize(commands, routes, final_map)
    @commands = commands
    @routes = routes
    @final_map = final_map
  end

  def calculate_total()
    [overhead_quantity, fuel_quantity, uncleared_quantity, paint_damage]
  end

  def overhead_quantity()
    @commands.length
  end

  def fuel_quantity()
    fuel_units = 0

    @routes.each do |route|
      route.each do |square|
        fuel_units += square.cost
      end
    end

    fuel_units
  end

  def paint_damage()
    paint_damage_units = 0

    @routes.each do |route|
      # For each "t" that is not the last square, add 1 paint damage unit
      filtered_route = route.slice(0..-2) # discard last elem
      num_of_damaging_trees = filtered_route
        .select { |square| square.type == :RemovableTree }
        .length
      paint_damage_units += num_of_damaging_trees
    end

    paint_damage_units
  end

  def uncleared_quantity()
    uncleared_squares = 0

    @final_map.each do |row|
      # Count number of squares that are not "cleared" or "protected"
      uncleared_squares += row
        .reject { |square| square.type == :Cleared || square.type == :ProtectedTree}
        .length
    end

    uncleared_squares
  end
end