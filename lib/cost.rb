class Cost
  def initialize(commands, routes, final_map)
    @commands = commands
    @routes = routes
    @final_map = final_map
    @unit_cost = {
      overhead: 1,
      fuel: 1,
      uncleared: 3,
      protected_tree: 10,
      paint_damage: 2
    }
  end

  def calculate_total()
    {
      overhead_quantity: overhead_quantity(),
      overhead_cost: overhead_quantity() * @unit_cost[:overhead],
      fuel_quantity: fuel_quantity(),
      fuel_cost: fuel_quantity() * @unit_cost[:fuel],
      uncleared_quantity: uncleared_quantity(),
      uncleared_cost: uncleared_quantity() * @unit_cost[:uncleared],
      paint_damage: paint_damage(),
      paint_damage_cost: paint_damage() * @unit_cost[:paint_damage]
    }
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