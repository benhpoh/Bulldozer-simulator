class Command
  attr_reader :commands_history

  def initialize(map_array)
    @response = {
      simulation_active: true,
      error_raised?: false,
      error_description: nil
    }
    @bulldozer = Bulldozer.new(map_array)
    @commands_history = []

  end

  def execute(input)
    command, advance_num = input.split(" ")

    case command
    when "l"
      @commands_history << "Turn left"
      @bulldozer.left()
    when "r"
      @commands_history << "Turn right"
      @bulldozer.right()
    when "a"
      advance_num.nil? ? advance_num = 1 : advance_num
      @commands_history << "Advance #{advance_num}"
      @bulldozer.advance(advance_num)
    when "m"
      map()
    when "q"
      @response[:simulation_active] = false
    else
      @response[:error_raised?] = true
      @response[:error_description] = "Invalid command"
    end

    @response
  end
end