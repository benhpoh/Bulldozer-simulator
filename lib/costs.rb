class Cost
  attr_reader :commands, :routes
  def initialize(commands, routes)
    @commands = commands
    @routes = routes
  end
end