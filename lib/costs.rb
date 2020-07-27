class Cost
  attr_reader :commands, :routes

  def initialize(commands, routes)
    @commands = commands
    @routes = routes
  end

  def overhead_cost()
    @commands.length
  end

  def fuel_cost()
    fuel_cost = 0

    @routes.each do |route|
      route.each do |square|
        if square == "t" || square == "r"
          fuel_cost += 2
        else
          fuel_cost += 1
        end
      end
    end

    fuel_cost
  end
end