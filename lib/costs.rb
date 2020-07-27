class Cost
  # attr_reader :commands, :routes # Test purposes only

  def initialize(commands, routes, final_map)
    @commands = commands
    @routes = routes
    @final_map = final_map
  end

  def overhead_cost()
    communication_units = @commands.length
  end

  def fuel_cost()
    fuel_units = 0

    @routes.each do |route|
      route.each do |square|
        if square == "t" || square == "r"
          fuel_units += 2
        else
          fuel_units += 1
        end
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
        .select { |square| square == "t" }
        .length
      paint_damage_units += num_of_damaging_trees
    end

    paint_damage_units
  end

  def uncleared_cost()
    uncleared_squares = 0

    @final_map.each do |row|
      # Count number of squares that are not "cleared" or "protected"
      uncleared_squares += row
        .reject { |square| square == "-" || square == "T" }
        .length
    end

    uncleared_squares
  end

  def calculate_costs()
    [overhead_cost, fuel_cost, uncleared_cost, paint_damage]
  end
end