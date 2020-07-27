class Cost
  attr_reader :commands, :routes

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
      # If route contains "t", calculate index of "t"s.
      # For each "t" that is not the last square, add 1 paint damage unit
      filtered_route = route.slice(0..-2) # discard last elem
      paint_damaging_trees = filtered_route
        .select { |square| square == "t" }
        .length
      paint_damage_units += paint_damaging_trees
    end

    paint_damage_units
  end
end