class Command
  def initialize(map_array)
    @response = {
      simulation_active: true,
      error_raised?: false,
      error_description: nil
    }
    @bulldozer = Bulldozer.new(map_array)

  end

  def execute(input)
    command, num_steps = input.split(" ")

    case command
    when "l"
      @bulldozer.left()
    when "r"
      @bulldozer.right()
    when "a"
      num_steps.nil? ? @bulldozer.advance(1) : @bulldozer.advance(num_steps)
    when "m"
      map()
    when "q"
      @response[:simulation_active] = false
    else
      [false, "Invalid command"]
    end

    @response
  end
end