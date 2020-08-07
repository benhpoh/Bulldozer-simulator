require_relative 'bulldozer'

class Command
  attr_reader :commands_history, :simulation_active

  def initialize(map_array)
    @simulation_active = true
    @bulldozer = Bulldozer.new(map_array)
    @commands_history = []

  end

  def execute(input)
    @response = {
      error_raised?: false,
      error_description: nil
    }
    return @response if !@simulation_active

    command, advance_steps = input.split(" ")

    case command
    when "l"
      @commands_history << "Turn left"
      @bulldozer.left()

    when "r"
      @commands_history << "Turn right"
      @bulldozer.right()

    when "a"
      advance_steps.nil? ? advance_steps = 1 : advance_steps
      @commands_history << "Advance #{advance_steps}"
      advance(advance_steps) 

    when "m"
      @bulldozer.map()

    when "q"
      @simulation_active = false
      @response[:error_description] = parse_error(:Q)

    else
      @response[:error_raised?] = true
      @response[:error_description] = parse_error(:INV)
    end

    @response
  end

  # Helper methods
  private

  def advance(advance_steps)
    adv_response = @bulldozer.advance(advance_steps)

    if adv_response[:advance_successful] == false
      @simulation_active = false
      @response[:error_raised?] = true
      @response[:error_description] = parse_error(adv_response[:error_code])
    end
  end

  def parse_error(error_code)
    if error_code == :INV
      return "Error, invalid command."
    elsif error_code == :T
      ending_reason = "due to an attempt to remove a protected tree"
    elsif error_code == :OUT
      ending_reason = "due to an attempt to exit the site boundaries"
    elsif error_code == :Q
      ending_reason = "at your request"
    end

    "\nThe simulation has ended #{ending_reason}. These are the commands you issued:\n "
  end
end