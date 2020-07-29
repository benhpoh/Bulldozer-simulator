class Cost
  # attr_reader :commands, :routes # Test purposes only

  def initialize(commands, routes, final_map)
    @commands = commands
    @routes = routes
    @final_map = final_map
  end
  ##### calculate total at the top has it's the most abstracted, think about the newspaper analogy in this case
  def calculate_total()
    [overhead_quantity, fuel_quantity, uncleared_quantity, paint_damage]
  end

  def overhead_quantity()
    communication_units = @commands.length
  end

  #### if feel like the three functions below are pretty heavy
  def fuel_quantity()
    fuel_units = 0

    @routes.each do |route|
      route.each do |square|
        if square == "t" || square == "r"
          fuel_units += 2                  ##### you could toy around with extracting the if/else block to calculate_fuel_used()
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
      ## the below block is weird but it s ok I guess
      num_of_damaging_trees = filtered_route
        .select { |square| square == "t" }
        .length

      paint_damage_units += num_of_damaging_trees
    end
    ##### how does calculated_paint_damage_units reads?
    paint_damage_units
  end

  def uncleared_quantity()
    uncleared_squares = 0

    @final_map.each do |row|  ##### is there a more domain-specific term?  lane?
      # Count number of squares that are not "cleared" or "protected"
      uncleared_squares += row
        .reject { |square| square == "-" || square == "T" }
        .length
    end

    uncleared_squares
  end
end